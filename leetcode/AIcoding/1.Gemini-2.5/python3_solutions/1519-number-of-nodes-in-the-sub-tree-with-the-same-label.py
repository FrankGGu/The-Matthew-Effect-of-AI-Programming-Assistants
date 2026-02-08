from collections import defaultdict

class Solution:
    def countSubTrees(self, n: int, edges: list[list[int]], labels: str) -> list[int]:
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        ans = [0] * n

        def dfs(u, parent):
            # Array to store frequency of each label (a-z) in the subtree rooted at u
            # Index 0 for 'a', 1 for 'b', ..., 25 for 'z'
            label_counts_in_subtree = [0] * 26

            # Recursively call DFS for children
            for v in adj[u]:
                if v == parent:
                    continue
                child_counts = dfs(v, u)
                # Merge child's label counts into current node's counts
                for i in range(26):
                    label_counts_in_subtree[i] += child_counts[i]

            # Add the current node's label to its own counts
            current_label_idx = ord(labels[u]) - ord('a')
            label_counts_in_subtree[current_label_idx] += 1

            # Store the result for the current node: count of its own label in its subtree
            ans[u] = label_counts_in_subtree[current_label_idx]

            return label_counts_in_subtree

        dfs(0, -1) # Start DFS from node 0, with a dummy parent -1
        return ans