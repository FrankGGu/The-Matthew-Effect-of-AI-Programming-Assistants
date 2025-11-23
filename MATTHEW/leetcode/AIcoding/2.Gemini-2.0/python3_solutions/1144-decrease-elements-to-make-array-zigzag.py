class Solution:
    def movesToMakeZigzag(self, nums: list[int]) -> int:
        n = len(nums)
        ans1 = 0
        ans2 = 0

        for i in range(0, n, 2):
            left = nums[i - 1] if i > 0 else float('inf')
            right = nums[i + 1] if i < n - 1 else float('inf')

            if nums[i] >= min(left, right):
                ans1 += nums[i] - min(left, right) + 1

        for i in range(1, n, 2):
            left = nums[i - 1] if i > 0 else float('inf')
            right = nums[i + 1] if i < n - 1 else float('inf')

            if nums[i] >= min(left, right):
                ans2 += nums[i] - min(left, right) + 1

        return min(ans1, ans2)