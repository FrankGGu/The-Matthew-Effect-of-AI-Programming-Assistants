def destroyTargets(nums, target):
    nums.sort()
    min_operations = float('inf')
    for num in nums:
        if num % target == 0:
            min_operations = min(min_operations, num // target)
    return min_operations if min_operations != float('inf') else -1