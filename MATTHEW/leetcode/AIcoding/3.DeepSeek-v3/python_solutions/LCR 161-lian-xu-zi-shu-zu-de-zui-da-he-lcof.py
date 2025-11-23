class Solution:
    def maxSales(self, sales: List[int]) -> int:
        max_current = max_global = sales[0]
        for num in sales[1:]:
            max_current = max(num, max_current + num)
            max_global = max(max_global, max_current)
        return max_global