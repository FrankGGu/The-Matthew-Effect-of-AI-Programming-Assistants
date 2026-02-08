class Solution:
    def construct2DArray(self, original: list[int], m: int, n: int) -> list[list[int]]:
        if len(original) != m * n:
            return []

        result = []
        for i in range(m):
            result.append(original[i * n : (i + 1) * n])

        return result