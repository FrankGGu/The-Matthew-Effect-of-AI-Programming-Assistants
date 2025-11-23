import collections

class TrieNode:
    def __init__(self):
        self.children = collections.defaultdict(TrieNode)
        self.count = 0 # Number of strings that have this prefix

class Solution:
    def longestCommonPrefix(self, strs: list[str], k: int) -> str:
        N = len(strs)

        # Edge case: If we need to remove all or more strings than available,
        # or if there are no strings to begin with, the LCP is an empty string.
        if N - k <= 0:
            return ""

        root = TrieNode()

        # Build the Trie and populate counts.
        # Each node's `count` stores how many of the original strings
        # have the prefix represented by that node.
        for s in strs:
            curr = root
            for char in s:
                curr = curr.children[char] # defaultdict creates node if not exists
                curr.count += 1

        target_count = N - k
        max_lcp_len = 0

        # First DFS pass: Find the maximum possible LCP length.
        # A node at depth 'd' represents a prefix of length 'd'.
        def find_max_len_dfs(node, depth):
            nonlocal max_lcp_len
            # If this prefix (represented by 'node') is common to at least target_count strings,
            # then 'depth' is a possible LCP length. We want to find the maximum such depth.
            if node.count >= target_count:
                max_lcp_len = max(max_lcp_len, depth)

            # Recurse for children
            for child_node in node.children.values():
                find_max_len_dfs(child_node, depth + 1)

        # Start DFS from the root (depth 0, representing the empty prefix "")
        find_max_len_dfs(root, 0)

        # If no common prefix of length > 0 was found (i.e., only empty prefix is valid), return ""
        if max_lcp_len == 0:
            return ""

        # Second DFS pass: Reconstruct the prefix string of max_lcp_len.
        # We need to find *any* path in the Trie that corresponds to max_lcp_len
        # and satisfies the count condition (which is guaranteed by max_lcp_len itself).
        result_prefix_chars = []
        def reconstruct_prefix_dfs(node, depth):
            # If we reached the desired LCP length, we've found our prefix.
            if depth == max_lcp_len:
                return True 

            # Explore children. The order of children doesn't matter as any valid prefix is fine.
            for char, child_node in node.children.items():
                # Optimization: Only explore children that could potentially lead to a valid prefix
                # of max_lcp_len. This means their count must be at least target_count.
                # This is technically not strictly necessary if `max_lcp_len` is already found,
                # as `max_lcp_len` implies there's *some* path. But it prunes branches.
                if child_node.count >= target_count:
                    result_prefix_chars.append(char)
                    if reconstruct_prefix_dfs(child_node, depth + 1):
                        return True # Path found, propagate up
                    result_prefix_chars.pop() # Backtrack if this path didn't lead to max_lcp_len
            return False

        reconstruct_prefix_dfs(root, 0)
        return "".join(result_prefix_chars)