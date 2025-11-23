class Solution:
    def gardenNoAdj(self, N: int, paths: List[List[int]]) -> List[int]:
        graph = [[] for _ in range(N + 1)]
        for u, v in paths:
            graph[u].append(v)
            graph[v].append(u)

        res = [0] * (N + 1)
        for i in range(1, N + 1):
            used = [False] * 5
            for neighbor in graph[i]:
                used[res[neighbor]] = True
            for color in range(1, 5):
                if not used[color]:
                    res[i] = color
                    break
        return res[1:]