def minSwaps(nums: list[int]) -> int:
    n = len(nums)
    ones = sum(nums)
    if ones == 0 or ones == n:
        return 0

    window_ones = 0
    for i in range(ones):
        window_ones += nums[i]

    max_ones = window_ones

    for i in range(ones, n):
        window_ones += nums[i]
        window_ones -= nums[i - ones]
        max_ones = max(max_ones, window_ones)

    return ones - max_ones