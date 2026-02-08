def sumOfVariableLengthSubarrays(nums: list[int], queries: list[list[int]]) -> list[int]:
    results = []
    for start, end in queries:
        subarray_sum = 0
        for i in range(start, end + 1):
            subarray_sum += nums[i]
        results.append(subarray_sum)
    return results