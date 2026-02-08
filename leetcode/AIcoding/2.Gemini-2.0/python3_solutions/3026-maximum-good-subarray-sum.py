def maxGoodSubarraySum(nums, k):
    prefix_sum = 0
    min_prefix_sum = {}
    max_sum = float('-inf')

    for num in nums:
        prefix_sum += num

        if prefix_sum - k in min_prefix_sum:
            max_sum = max(max_sum, prefix_sum - min_prefix_sum[prefix_sum - k])
        if prefix_sum + k in min_prefix_sum:
            max_sum = max(max_sum, prefix_sum - min_prefix_sum[prefix_sum + k])

        if prefix_sum not in min_prefix_sum:
            min_prefix_sum[prefix_sum] = prefix_sum
        else:
            min_prefix_sum[prefix_sum] = min(min_prefix_sum[prefix_sum], prefix_sum)

    return max_sum if max_sum != float('-inf') else 0