def countNonDecreasingSubarraysAfterKOperations(nums, k):
    n = len(nums)
    ans = 0
    for i in range(n):
        l, r = i, i
        ops = k
        while r < n - 1:
            if nums[r + 1] >= nums[r]:
                r += 1
            elif ops > 0:
                ops -= 1
                r += 1
            else:
                break
        ans += r - i + 1
    return ans