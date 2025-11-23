from typing import List

class Solution:
    def judgePoint24(self, cards: List[int]) -> bool:
        def dfs(nums):
            if len(nums) == 1:
                return abs(nums[0] - 24) < 1e-6
            for i in range(len(nums)):
                for j in range(len(nums)):
                    if i != j:
                        next_nums = []
                        for k in range(len(nums)):
                            if k != i and k != j:
                                next_nums.append(nums[k])
                        for num in [nums[i] + nums[j], nums[i] - nums[j], nums[j] - nums[i], nums[i] * nums[j]]:
                            next_nums.append(num)
                            if dfs(next_nums):
                                return True
                            next_nums.pop()
                        if nums[j] != 0:
                            next_nums.append(nums[i] / nums[j])
                            if dfs(next_nums):
                                return True
                            next_nums.pop()
            return False
        return dfs(cards)