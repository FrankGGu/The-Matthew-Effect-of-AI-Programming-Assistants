class Solution:
    def solve(self, graph: list[list[int]], values: str) -> int:
        n = len(graph)
        adj = [[] for _ in range(n)]
        for u, v in graph:
            adj[u].append(v)
            adj[v].append(u)

        def dfs(node, parent, path):
            path.append(values[node])

            is_palindrome = True
            counts = {}
            for char in path:
                counts[char] = counts.get(char, 0) + 1

            odd_count = 0
            for char in counts:
                if counts[char] % 2 != 0:
                    odd_count += 1

            if odd_count > 1:
                is_palindrome = False

            if is_palindrome:
                self.count += 1

            for neighbor in adj[node]:
                if neighbor != parent:
                    dfs(neighbor, node, path[:])

        self.count = 0
        for i in range(n):
            dfs(i, -1, [])

        return self.count