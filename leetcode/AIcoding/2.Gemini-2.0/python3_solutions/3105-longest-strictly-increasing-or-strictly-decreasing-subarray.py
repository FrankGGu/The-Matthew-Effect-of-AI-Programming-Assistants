def longestSubsequence(nums: list[int]) -> int:
    n = len(nums)
    if n <= 1:
        return n

    max_len = 1

    # Increasing
    curr_len = 1
    for i in range(1, n):
        if nums[i] > nums[i-1]:
            curr_len += 1
        else:
            max_len = max(max_len, curr_len)
            curr_len = 1
    max_len = max(max_len, curr_len)

    # Decreasing
    curr_len = 1
    for i in range(1, n):
        if nums[i] < nums[i-1]:
            curr_len += 1
        else:
            max_len = max(max_len, curr_len)
            curr_len = 1
    max_len = max(max_len, curr_len)

    return max_len