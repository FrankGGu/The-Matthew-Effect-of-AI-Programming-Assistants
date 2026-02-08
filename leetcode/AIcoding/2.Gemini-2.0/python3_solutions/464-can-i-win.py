class Solution:
    def canIWin(self, maxChoosableInteger: int, desiredTotal: int) -> bool:
        if desiredTotal <= 0:
            return True
        if (1 + maxChoosableInteger) * maxChoosableInteger // 2 < desiredTotal:
            return False

        memo = {}

        def solve(nums, target):
            key = tuple(nums)
            if key in memo:
                return memo[key]

            if max(nums) >= target:
                return True

            for i in range(len(nums)):
                new_nums = nums[:i] + nums[i+1:]
                if not solve(new_nums, target - nums[i]):
                    memo[key] = True
                    return True

            memo[key] = False
            return False

        nums = list(range(1, maxChoosableInteger + 1))
        return solve(nums, desiredTotal)