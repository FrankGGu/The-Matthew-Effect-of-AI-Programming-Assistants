class Solution:
    def tallestBillboard(self, rods: List[int]) -> int:
        dp = {0: 0}
        for rod in rods:
            new_dp = defaultdict(int)
            for diff in dp:
                new_diff = diff + rod
                new_dp[new_diff] = max(new_dp[new_diff], dp[diff] + rod)
                new_diff = abs(diff - rod)
                new_dp[new_diff] = max(new_dp[new_diff], max(dp[diff], dp[diff] - diff + rod))
            for diff in new_dp:
                if diff in dp:
                    dp[diff] = max(dp[diff], new_dp[diff])
                else:
                    dp[diff] = new_dp[diff]
        return dp.get(0, 0)