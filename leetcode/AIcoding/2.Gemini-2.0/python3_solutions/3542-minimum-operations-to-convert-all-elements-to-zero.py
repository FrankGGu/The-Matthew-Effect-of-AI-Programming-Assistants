def minimumOperations(nums: list[int]) -> int:
    count = 0
    while any(nums):
        min_val = float('inf')
        for num in nums:
            if num > 0 and num < min_val:
                min_val = num
        if min_val == float('inf'):
            break
        for i in range(len(nums)):
            if nums[i] > 0:
                nums[i] -= min_val
        count += 1
    return count