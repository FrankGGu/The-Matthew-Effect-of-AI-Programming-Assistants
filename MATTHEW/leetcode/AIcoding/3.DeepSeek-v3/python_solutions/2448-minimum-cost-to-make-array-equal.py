class Solution:
    def minCost(self, nums: List[int], cost: List[int]) -> int:
        arr = sorted(zip(nums, cost))
        total = sum(cost)
        median = 0
        count = 0
        for num, c in arr:
            count += c
            if count > total // 2:
                median = num
                break

        res = 0
        for num, c in arr:
            res += abs(num - median) * c
        return res