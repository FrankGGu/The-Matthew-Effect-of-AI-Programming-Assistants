def find_largest_outlier(nums: list[int]) -> int:
    n = len(nums)
    if n < 3:
        return -1

    nums.sort()

    if abs(nums[0] - nums[1]) > abs(nums[-1] - nums[-2]):
        if abs(nums[0] - nums[1]) > abs(nums[0] - nums[2]):
            return nums[0]
        else:
            return -1
    else:
        if abs(nums[-1] - nums[-2]) > abs(nums[-1] - nums[-3]):
            return nums[-1]
        else:
            return -1