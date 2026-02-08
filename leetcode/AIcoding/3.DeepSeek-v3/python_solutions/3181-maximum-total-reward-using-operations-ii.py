class Solution:
    def maxTotalReward(self, rewardValues: List[int]) -> int:
        rewardValues = sorted(list(set(rewardValues)))
        max_reward = 0
        dp = {0}
        for r in rewardValues:
            new_dp = set()
            for x in dp:
                if x < r:
                    new_dp.add(x + r)
            dp.update(new_dp)
        return max(dp) if dp else 0