def minIncrements(nums, k):
    n = len(nums)
    increments = 0
    for i in range(n):
        if nums[i] % k == 0:
            continue
        increments += (k - (nums[i] % k))
        nums[i] += (k - (nums[i] % k))
    return increments