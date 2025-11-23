def countSubarrays(nums: List[int]) -> int:
    count = 0
    for i in range(len(nums) - 2):
        if (nums[i] > nums[i + 1] and nums[i + 1] > nums[i + 2]) or (nums[i] < nums[i + 1] and nums[i + 1] < nums[i + 2]):
            count += 1
    return count