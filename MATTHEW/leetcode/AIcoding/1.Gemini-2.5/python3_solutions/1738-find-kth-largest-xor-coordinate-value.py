class Solution:
    def kthLargestValue(self, matrix: list[list[int]], k: int) -> int:
        m = len(matrix)
        n = len(matrix[0])

        dp = [[0] * (n + 1) for _ in range(m + 1)]
        xor_values = []

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                dp[i][j] = matrix[i-1][j-1] ^ dp[i-1][j] ^ dp[i][j-1] ^ dp[i-1][j-1]
                xor_values.append(dp[i][j])

        xor_values.sort(reverse=True)
        return xor_values[k-1]