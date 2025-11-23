class Solution:
    def minimizeArrayValue(self, nums: List[int]) -> int:
        left, right = max(nums), sum(nums) // len(nums) + 1

        while left > right:
            mid = (left + right) // 2
            total, count = 0, 0

            for num in nums:
                total += min(num, mid)
                count += max(0, num - mid)

            if total + count >= mid * len(nums):
                left = mid
            else:
                right = mid - 1

        return left