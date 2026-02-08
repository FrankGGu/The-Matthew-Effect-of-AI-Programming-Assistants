class Solution:
    def purchasePlans(self, costs: List[int], money: int) -> int:
        costs.sort()
        left, right = 0, len(costs) - 1
        count = 0
        while left < right:
            if costs[left] + costs[right] <= money:
                count += right - left
                left += 1
            else:
                right -= 1
        return count % 1000000007