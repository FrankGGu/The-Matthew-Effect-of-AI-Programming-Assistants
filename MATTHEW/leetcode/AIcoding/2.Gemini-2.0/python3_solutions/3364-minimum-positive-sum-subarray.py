def minSubarray(nums):
    n = len(nums)
    min_sum = float('inf')
    for i in range(n):
        current_sum = 0
        for j in range(i, n):
            current_sum += nums[j]
            if current_sum > 0:
                min_sum = min(min_sum, current_sum)

    if min_sum == float('inf'):
        return -1
    else:
        return min_sum