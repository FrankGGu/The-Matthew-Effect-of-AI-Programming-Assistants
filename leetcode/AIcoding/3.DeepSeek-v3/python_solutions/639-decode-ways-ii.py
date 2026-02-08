class Solution:
    def numDecodings(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)
        dp = [0] * (n + 1)
        dp[0] = 1
        if s[0] == '0':
            dp[1] = 0
        elif s[0] == '*':
            dp[1] = 9
        else:
            dp[1] = 1

        for i in range(2, n + 1):
            first = s[i-2]
            second = s[i-1]

            # Single digit
            if second == '*':
                dp[i] += 9 * dp[i-1]
            elif second != '0':
                dp[i] += dp[i-1]

            # Two digits
            if first == '*':
                if second == '*':
                    dp[i] += 15 * dp[i-2]
                elif '0' <= second <= '6':
                    dp[i] += 2 * dp[i-2]
                else:
                    dp[i] += dp[i-2]
            elif first == '1':
                if second == '*':
                    dp[i] += 9 * dp[i-2]
                else:
                    dp[i] += dp[i-2]
            elif first == '2':
                if second == '*':
                    dp[i] += 6 * dp[i-2]
                elif '0' <= second <= '6':
                    dp[i] += dp[i-2]

            dp[i] %= MOD

        return dp[n]