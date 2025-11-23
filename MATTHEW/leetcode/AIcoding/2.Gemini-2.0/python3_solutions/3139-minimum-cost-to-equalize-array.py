def minCost(nums: list[int], cost: list[int]) -> int:
    l, r = min(nums), max(nums)
    ans = float('inf')

    def calculate_cost(target):
        res = 0
        for i in range(len(nums)):
            res += abs(nums[i] - target) * cost[i]
        return res

    while l < r:
        mid = (l + r) // 2
        cost1 = calculate_cost(mid)
        cost2 = calculate_cost(mid + 1)
        ans = min(ans, cost1, cost2)
        if cost1 < cost2:
            r = mid
        else:
            l = mid + 1
    ans = min(ans, calculate_cost(l))
    return ans