def maxFrequencyScore(nums: list[int], k: int) -> int:
    nums.sort()
    n = len(nums)
    l, r = 0, 0
    ans = 0
    curr_sum = 0
    while r < n:
        curr_sum += nums[r]
        while (r - l + 1) * nums[r] - curr_sum > k:
            curr_sum -= nums[l]
            l += 1
        ans = max(ans, r - l + 1)
        r += 1
    return ans