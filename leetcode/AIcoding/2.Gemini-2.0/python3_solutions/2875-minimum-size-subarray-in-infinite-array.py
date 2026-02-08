def minSizeSubarray(nums: list[int], target: int) -> int:
    n = len(nums)
    s = sum(nums)
    k = target // s
    target %= s
    ans = float('inf')
    curr = 0
    l = 0
    for r in range(2 * n):
        curr += nums[r % n]
        while curr > target:
            curr -= nums[l % n]
            l += 1
        if curr == target:
            ans = min(ans, r - l + 1)
    if ans == float('inf'):
        return -1
    return ans + k * n