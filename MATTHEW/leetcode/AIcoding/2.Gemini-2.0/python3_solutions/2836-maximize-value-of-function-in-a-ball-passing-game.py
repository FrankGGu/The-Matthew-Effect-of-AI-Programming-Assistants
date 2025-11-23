class Solution:
    def getMaxFunctionValue(self, receiver: list[int], k: int) -> int:
        n = len(receiver)
        log_k = 0
        temp = k
        while temp > 0:
            log_k += 1
            temp //= 2

        dp = [[0] * n for _ in range(log_k)]
        sum_dp = [[0] * n for _ in range(log_k)]

        for i in range(n):
            dp[0][i] = receiver[i]
            sum_dp[0][i] = receiver[i]

        for i in range(1, log_k):
            for j in range(n):
                dp[i][j] = dp[i - 1][dp[i - 1][j]]
                sum_dp[i][j] = sum_dp[i - 1][j] + sum_dp[i - 1][dp[i - 1][j]]

        ans = 0
        for start in range(n):
            curr = start
            curr_sum = 0
            remaining_k = k
            for i in range(log_k - 1, -1, -1):
                if remaining_k >= (1 << i):
                    curr_sum += sum_dp[i][curr]
                    curr = dp[i][curr]
                    remaining_k -= (1 << i)
            ans = max(ans, curr_sum + start)

        return ans