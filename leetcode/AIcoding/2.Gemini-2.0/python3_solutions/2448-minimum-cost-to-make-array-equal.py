class Solution:
    def minCost(self, nums: List[int], cost: List[int]) -> int:
        l, r = min(nums), max(nums)
        ans = float('inf')
        while l <= r:
            mid = (l + r) // 2
            cost1 = sum(abs(x - mid) * y for x, y in zip(nums, cost))
            cost2 = sum(abs(x - (mid + 1)) * y for x, y in zip(nums, cost))
            ans = min(ans, cost1, cost2)
            if cost1 < cost2:
                r = mid - 1
            else:
                l = mid + 1
        return ans