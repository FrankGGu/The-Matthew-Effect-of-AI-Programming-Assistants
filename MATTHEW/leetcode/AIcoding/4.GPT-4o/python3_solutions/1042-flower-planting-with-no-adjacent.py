class Solution:
    def gardenNoAdj(self, n: int, paths: List[List[int]]) -> List[int]:
        graph = [[] for _ in range(n)]
        for u, v in paths:
            graph[u - 1].append(v - 1)
            graph[v - 1].append(u - 1)

        res = [0] * n

        for i in range(n):
            forbidden = {res[neighbor] for neighbor in graph[i]}
            for color in range(1, 5):
                if color not in forbidden:
                    res[i] = color
                    break

        return res