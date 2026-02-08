class Solution:
    def countFairPairs(self, nums: List[int], lower: int, upper: int) -> int:
        nums.sort()
        n = len(nums)
        res = 0

        for i in range(n):
            left = i + 1
            right = n - 1
            lower_bound = lower - nums[i]
            upper_bound = upper - nums[i]

            # Find the first index where nums[j] >= lower_bound
            l = bisect.bisect_left(nums, lower_bound, left, right + 1)
            # Find the first index where nums[j] > upper_bound
            r = bisect.bisect_right(nums, upper_bound, left, right + 1)

            res += r - l

        return res