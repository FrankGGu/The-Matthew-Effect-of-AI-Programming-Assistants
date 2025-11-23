def maximumDifference(nums):
    min_even = float('inf')
    max_odd = float('-inf')

    for num in nums:
        if num % 2 == 0:
            min_even = min(min_even, num)
        else:
            max_odd = max(max_odd, num)

    return max_odd - min_even if max_odd != float('-inf') and min_even != float('inf') else -1