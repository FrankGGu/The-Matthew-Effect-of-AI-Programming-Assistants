class Solution:
    def gardenNoAdj(self, n: int, paths: list[list[int]]) -> list[int]:
        adj = [[] for _ in range(n)]
        for u, v in paths:
            adj[u - 1].append(v - 1)
            adj[v - 1].append(u - 1)

        answer = [0] * n

        for i in range(n):
            used_colors = [False] * 5  # Index 0 unused, 1-4 for colors
            for neighbor in adj[i]:
                if answer[neighbor] != 0:
                    used_colors[answer[neighbor]] = True

            for color in range(1, 5):
                if not used_colors[color]:
                    answer[i] = color
                    break

        return answer