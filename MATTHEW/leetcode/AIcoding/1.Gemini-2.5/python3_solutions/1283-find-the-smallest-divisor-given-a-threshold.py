class Solution:
    def smallestDivisor(self, nums: list[int], threshold: int) -> int:
        def check(divisor: int) -> bool:
            current_sum = 0
            for num in nums:
                current_sum += (num + divisor - 1) // divisor
            return current_sum <= threshold

        low = 1
        high = max(nums)
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans