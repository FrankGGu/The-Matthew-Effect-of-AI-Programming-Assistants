class Solution:
    def highestSales(self, sales: List[int]) -> int:
        max_sales = 0
        current_sales = 0

        for sale in sales:
            if sale > 0:
                current_sales += sale
            else:
                max_sales = max(max_sales, current_sales)
                current_sales = 0

        return max(max_sales, current_sales)