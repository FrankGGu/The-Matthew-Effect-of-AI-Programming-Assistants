class Solution:
    def solveQueries(self, n: int, queries: list[list[int]]) -> list[int]:
        blocks = [0] * n
        result = []
        for query in queries:
            l, r = query
            height = 0
            for i in range(l, r + 1):
                blocks[i] += 1
                height = max(height, blocks[i])
            result.append(height)
        return result