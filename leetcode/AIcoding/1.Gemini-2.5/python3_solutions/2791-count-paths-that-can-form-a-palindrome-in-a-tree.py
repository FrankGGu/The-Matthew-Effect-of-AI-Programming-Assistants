import collections

class Solution:
    def countPalindromePaths(self, n: int, parent: list[int], s: str) -> int:
        adj = collections.defaultdict(list)
        # Build adjacency list for an undirected tree
        for i in range(1, n):
            adj[parent[i]].append(i)
            adj[i].append(parent[i])

        # mask_counts stores the frequency of XOR sums of character parities from the root to a node.
        # For a path between nodes u and v, the XOR sum of character parities is M_u ^ M_v,
        # where M_x is the XOR sum of parities on the path from the root to node x (inclusive).
        # This M_u ^ M_v effectively excludes the character at LCA(u,v) from the path's XOR sum.
        # A path can form a palindrome if its character parity mask is 0 (all even counts)
        # or has exactly one bit set (one character has an odd count).

        # Initialize mask_counts with {0: 1} to account for the "virtual" path from a non-existent
        # parent to the root (node 0), which has an XOR sum of 0. This helps correctly count
        # paths starting at the root.
        mask_counts = collections.defaultdict(int)
        mask_counts[0] = 1 

        # total_palindrome_pairs will count ordered pairs (u,v) such that u != v and
        # the path u-v forms a palindrome (based on M_u ^ M_v mask).
        total_palindrome_pairs = 0

        # DFS function to traverse the tree
        # u: current node
        # p: parent of current node (to avoid going back up)
        # current_mask: XOR sum of character parities from the root to the parent node p
        def dfs(u, p, current_mask_to_p):
            nonlocal total_palindrome_pairs

            # Calculate the XOR sum of character parities from root to current node u
            char_val = int(s[u])
            current_mask_to_u = current_mask_to_p ^ (1 << char_val)

            # Count paths (u, v) where v is an already visited node (ancestor or in a sibling subtree)
            # A path u-v is a palindrome if M_u ^ M_v = 0 or M_u ^ M_v = (1 << k) for some k.
            # Case 1: M_u ^ M_v = 0  =>  M_v = M_u
            total_palindrome_pairs += mask_counts[current_mask_to_u]

            # Case 2: M_u ^ M_v = (1 << k)  =>  M_v = M_u ^ (1 << k)
            # Iterate through all possible single-bit masks (for digits '0' through '9')
            for k in range(10):
                total_palindrome_pairs += mask_counts[current_mask_to_u ^ (1 << k)]

            # Add the current node's mask to the frequency map
            mask_counts[current_mask_to_u] += 1

            # Recursively call DFS for children
            for v in adj[u]:
                if v != p:
                    dfs(v, u, current_mask_to_u)

            # Backtrack: remove the current node's mask from the frequency map.
            # This is crucial because mask_counts should only contain masks of nodes
            # that are ancestors of the current node's path or in subtrees already fully explored
            # and "to the left" of the current DFS path.
            mask_counts[current_mask_to_u] -= 1

        # Start DFS from the root (node 0). Its parent is -1 (non-existent) and initial mask is 0.
        dfs(0, -1, 0)

        # The total_palindrome_pairs variable now holds the count of ordered pairs (u,v) where u != v
        # and the path u-v forms a palindrome. Since an undirected path (u,v) is counted twice
        # (once as (u,v) and once as (v,u)), we divide this count by 2.
        #
        # Additionally, single-node paths (u,u) are always palindromes (a single character always forms a palindrome).
        # The mask for a single-node path (u) is (1 << char_at_u), which always has exactly one bit set.
        # These N single-node paths are not counted by the total_palindrome_pairs logic (as M_u ^ M_u = 0,
        # which represents an empty path's character set, not a single character).
        # So, we add N to the final result.
        return n + (total_palindrome_pairs // 2)