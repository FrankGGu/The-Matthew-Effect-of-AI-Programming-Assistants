class Solution:
    def maxTotalReward(self, rewardValues: List[int]) -> int:
        rewardValues = sorted(list(set(rewardValues)))
        max_reward = 0
        dp = {0}

        for num in rewardValues:
            new_dp = set()
            for val in dp:
                if val < num:
                    new_val = val + num
                    if new_val > max_reward:
                        max_reward = new_val
                    new_dp.add(new_val)
            dp.update(new_dp)

        return max_reward