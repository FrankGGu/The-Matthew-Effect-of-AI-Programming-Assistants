class Solution:
    def integerBreak(self, n: int) -> int:
        dp = [0] * (n + 1)
        dp[1] = 1 

        for i in range(2, n + 1):
            max_prod_for_i = 0
            for j in range(1, i // 2 + 1):
                # Option 1: Break i into j and (i-j), where (i-j) is not further broken
                prod1 = j * (i - j)
                # Option 2: Break i into j and (i-j), where (i-j) is further broken
                prod2 = j * dp[i - j]
                max_prod_for_i = max(max_prod_for_i, prod1, prod2)
            dp[i] = max_prod_for_i

        return dp[n]