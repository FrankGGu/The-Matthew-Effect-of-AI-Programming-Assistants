class Solution:
    def findPartition(self, matrix: list[list[int]]) -> int:
        n = len(matrix)
        for i in range(1, n):
            top_sum = sum(sum(row) for row in matrix[:i])
            bottom_sum = sum(sum(row) for row in matrix[i:])
            if top_sum == bottom_sum:
                return i
        return -1