def shortestSubarray(nums, k):
    n = len(nums)
    prefix_or = [0] * (n + 1)
    for i in range(n):
        prefix_or[i + 1] = prefix_or[i] | nums[i]

    if prefix_or[n] < k:
        return -1

    if k == 0:
        return 1

    ans = n
    for i in range(n):
        if nums[i] >= k:
            return 1

    for i in range(n):
        for j in range(i, n):
            if prefix_or[j+1] >= k:
                ans = min(ans, j - i + 1)
                break

    return ans