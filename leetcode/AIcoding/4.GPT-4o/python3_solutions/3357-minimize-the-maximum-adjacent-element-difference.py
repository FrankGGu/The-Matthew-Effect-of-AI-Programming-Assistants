class Solution:
    def minimizeArrayValue(self, nums: List[int]) -> int:
        left, right = max(nums), sum(nums) // len(nums) + 1

        while left > right:
            mid = (left + right) // 2
            total = 0
            for num in nums:
                total += min(num, mid)
            if total <= mid * len(nums):
                left = mid
            else:
                right = mid - 1

        return left