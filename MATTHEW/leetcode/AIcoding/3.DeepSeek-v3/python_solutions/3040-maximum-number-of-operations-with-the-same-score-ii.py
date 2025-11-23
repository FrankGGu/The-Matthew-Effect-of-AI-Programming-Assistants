class Solution:
    def maxOperations(self, nums: List[int]) -> int:
        n = len(nums)
        if n < 2:
            return 0

        memo = {}

        def dfs(l, r, target):
            if l >= r:
                return 0
            if (l, r, target) in memo:
                return memo[(l, r, target)]
            res = 0
            if nums[l] + nums[l + 1] == target:
                res = max(res, 1 + dfs(l + 2, r, target))
            if nums[r] + nums[r - 1] == target:
                res = max(res, 1 + dfs(l, r - 2, target))
            if nums[l] + nums[r] == target:
                res = max(res, 1 + dfs(l + 1, r - 1, target))
            memo[(l, r, target)] = res
            return res

        option1 = dfs(2, n - 1, nums[0] + nums[1]) + 1 if n >= 2 else 0
        option2 = dfs(0, n - 3, nums[-1] + nums[-2]) + 1 if n >= 2 else 0
        option3 = dfs(1, n - 2, nums[0] + nums[-1]) + 1 if n >= 2 else 0

        return max(option1, option2, option3)