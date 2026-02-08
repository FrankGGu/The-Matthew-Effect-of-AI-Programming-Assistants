def minimumAverage(nums):
    nums.sort()
    return (nums[0] + nums[-1]) / 2