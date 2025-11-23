from collections import defaultdict

class Solution:
    def longestPath(self, parent: list[int], s: str) -> int:
        n = len(parent)
        adj = defaultdict(list)

        # Build adjacency list for the tree
        # Node 0 is the root, parent[0] is -1
        for i in range(1, n):
            adj[parent[i]].append(i)
            adj[i].append(parent[i])

        # Initialize the maximum path length found so far to 1
        # (a single node is always a valid path of length 1)
        self.max_overall_path = 1 

        # DFS function to traverse the tree and calculate path lengths
        # u: current node, p: parent of current node
        def dfs(u, p):
            # longest_branch and second_longest_branch store the lengths
            # of the two longest valid paths starting from u and going downwards
            # through different children, where the child's character is different from s[u].
            longest_branch = 0
            second_longest_branch = 0

            # Iterate over all neighbors of u
            for v in adj[u]:
                if v == p: # Skip the parent to avoid going back up the tree
                    continue

                # Recursively call DFS for the child node
                len_from_child = dfs(v, u)

                # If the character of the child node is different from the current node,
                # this branch can be part of a valid path.
                if s[u] != s[v]:
                    # Update longest_branch and second_longest_branch
                    if len_from_child > longest_branch:
                        second_longest_branch = longest_branch
                        longest_branch = len_from_child
                    elif len_from_child > second_longest_branch:
                        second_longest_branch = len_from_child

            # Update the global maximum path. This considers paths that pass through 'u'
            # by joining the two longest valid downward branches (if any) at 'u'.
            # 1 is added for the node 'u' itself.
            self.max_overall_path = max(self.max_overall_path, 1 + longest_branch + second_longest_branch)

            # Return the length of the longest valid path starting at 'u' and going downwards,
            # including 'u'. This value will be used by 'u's parent to extend its path.
            return 1 + longest_branch

        # Start DFS from the root node (node 0), with a dummy parent -1
        dfs(0, -1) 

        return self.max_overall_path