class Solution:
    def tallestBillboard(self, rods: List[int]) -> int:
        dp = {0: 0}
        for length in rods:
            new_dp = dp.copy()
            for diff, height in dp.items():
                new_dp[diff + length] = max(new_dp.get(diff + length, 0), height)
                new_dp[diff + length - 2 * length] = max(new_dp.get(diff + length - 2 * length, 0), height + 2 * length)
            dp = new_dp
        return dp.get(0, 0)