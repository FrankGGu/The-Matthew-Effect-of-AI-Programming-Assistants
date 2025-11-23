class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        m, n = len(s), len(p)

        dp = [False] * (n + 1)

        dp[0] = True

        for j in range(1, n + 1):
            if p[j - 1] == '*':
                dp[j] = dp[j - 1]
            else:
                break 

        for i in range(1, m + 1):
            new_dp = [False] * (n + 1)

            prev_diag_val = dp[0] 

            for j in range(1, n + 1):
                current_dp_val_from_prev_row = dp[j] 

                if p[j - 1] == s[i - 1] or p[j - 1] == '?':
                    new_dp[j] = prev_diag_val 
                elif p[j - 1] == '*':
                    new_dp[j] = new_dp[j - 1] or current_dp_val_from_prev_row
                else:
                    new_dp[j] = False 

                prev_diag_val = current_dp_val_from_prev_row

            dp = new_dp 

        return dp[n]