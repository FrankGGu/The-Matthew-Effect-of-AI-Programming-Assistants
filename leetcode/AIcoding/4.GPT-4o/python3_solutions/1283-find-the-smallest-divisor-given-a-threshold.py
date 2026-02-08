class Solution:
    def smallestDivisor(self, nums: List[int], threshold: int) -> int:
        def sufficient(divisor):
            return sum((num + divisor - 1) // divisor for num in nums) <= threshold

        left, right = 1, max(nums)
        while left < right:
            mid = (left + right) // 2
            if sufficient(mid):
                right = mid
            else:
                left = mid + 1
        return left