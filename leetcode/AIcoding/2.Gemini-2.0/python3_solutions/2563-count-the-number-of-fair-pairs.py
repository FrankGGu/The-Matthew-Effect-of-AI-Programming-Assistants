class Solution:
    def countFairPairs(self, nums: list[int], lower: int, upper: int) -> int:
        nums.sort()
        count = 0
        for i in range(len(nums)):
            left = i + 1
            right_lower = len(nums)
            while left < right_lower:
                mid = (left + right_lower) // 2
                if nums[i] + nums[mid] >= lower:
                    right_lower = mid
                else:
                    left = mid + 1
            lower_bound = left

            left = i + 1
            right_upper = len(nums)
            while left < right_upper:
                mid = (left + right_upper) // 2
                if nums[i] + nums[mid] > upper:
                    right_upper = mid
                else:
                    left = mid + 1
            upper_bound = left

            count += upper_bound - lower_bound
        return count