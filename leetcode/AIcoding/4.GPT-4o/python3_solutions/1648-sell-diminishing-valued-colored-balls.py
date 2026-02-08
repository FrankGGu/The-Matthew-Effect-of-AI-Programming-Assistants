class Solution:
    def maxProfit(self, inventory: List[int], orders: int) -> int:
        inventory.sort(reverse=True)
        total_profit = 0
        mod = 10**9 + 7

        def calculate_profit(height, count):
            return height * (height + 1) // 2 - (height - count) * (height - count + 1) // 2

        for i in range(len(inventory)):
            if orders == 0:
                break
            if i < len(inventory) - 1:
                height = inventory[i]
                next_height = inventory[i + 1]
                count = min(orders, (height - next_height) * (i + 1))
                total_profit += calculate_profit(height, count)
                orders -= count
            else:
                count = min(orders, height)
                total_profit += calculate_profit(height, count)
                orders -= count

        return total_profit % mod