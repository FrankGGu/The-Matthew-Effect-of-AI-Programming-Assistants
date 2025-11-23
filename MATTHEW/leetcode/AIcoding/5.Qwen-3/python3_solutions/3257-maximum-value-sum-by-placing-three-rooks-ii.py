class Solution:
    def maximumValueSum(self, board: List[List[int]]) -> int:
        rows = [0] * 8
        cols = [0] * 8
        for i in range(8):
            for j in range(8):
                rows[i] += board[i][j]
                cols[j] += board[i][j]

        max_sum = 0
        for i in range(8):
            for j in range(8):
                current = rows[i] + cols[j] - board[i][j]
                if current > max_sum:
                    max_sum = current

        return max_sum