import bisect

class Solution:
    def countFairPairs(self, nums: list[int], lower: int, upper: int) -> int:
        nums.sort()
        n = len(nums)

        def count_pairs_less_equal(target: int) -> int:
            count = 0
            left = 0
            right = n - 1
            while left < right:
                if nums[left] + nums[right] <= target:
                    count += (right - left)
                    left += 1
                else:
                    right -= 1
            return count

        return count_pairs_less_equal(upper) - count_pairs_less_equal(lower - 1)