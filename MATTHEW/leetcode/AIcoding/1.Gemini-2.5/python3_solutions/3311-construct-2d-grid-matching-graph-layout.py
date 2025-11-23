class Solution:
    def construct2DGrid(self, original: list[int], m: int, n: int) -> list[list[int]]:
        if len(original) != m * n:
            return []

        grid = []
        for i in range(m):
            grid.append(original[i * n : (i + 1) * n])
        return grid