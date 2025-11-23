class Solution:
    def minimizeArrayValue(self, nums: List[int]) -> int:
        left, right = max(nums), sum(nums) // len(nums)

        while left > right:
            mid = (left + right) // 2
            total = 0
            current = 0

            for num in nums:
                current = max(current + num - mid, 0)
                total += current

            if total <= mid:
                left = mid
            else:
                right = mid - 1

        return left