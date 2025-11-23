from collections import deque, defaultdict

class Solution:
    def findMinHeightTrees(self, n: int, edges: List[List[int]]) -> List[int]:
        if n == 1:
            return [0]

        adj = defaultdict(set)
        for u, v in edges:
            adj[u].add(v)
            adj[v].add(u)

        leaves = deque([i for i in range(n) if len(adj[i]) == 1])

        while n > 2:
            for _ in range(len(leaves)):
                leaf = leaves.popleft()
                n -= 1
                for neighbor in adj[leaf]:
                    adj[neighbor].remove(leaf)
                    if len(adj[neighbor]) == 1:
                        leaves.append(neighbor)

        return list(leaves)