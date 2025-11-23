class Solution:
    def largestNumber(self, cost: List[int], target: int) -> str:
        dp = [""] * (target + 1)
        dp[0] = ""
        for t in range(1, target + 1):
            dp[t] = "0"
            for i in range(9):
                c = cost[i]
                if t >= c and dp[t - c] != "0":
                    new_num = str(i + 1) + dp[t - c]
                    if int(new_num) > int(dp[t]):
                        dp[t] = str(i + 1) + dp[t - c]
                    elif int(new_num) == int(dp[t]) and len(new_num) > len(dp[t]):
                         dp[t] = str(i + 1) + dp[t - c]

        return "".join(sorted(dp[target], reverse=True)) if dp[target] != "0" else "0"