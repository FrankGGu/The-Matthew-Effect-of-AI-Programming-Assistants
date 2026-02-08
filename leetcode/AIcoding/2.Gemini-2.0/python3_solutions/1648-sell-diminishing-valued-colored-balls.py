class Solution:
    def maxProfit(self, inventory: list[int], orders: int) -> int:
        inventory.sort(reverse=True)
        inventory.append(0)
        ans = 0
        width = 1
        for i in range(len(inventory) - 1):
            if inventory[i] > inventory[i + 1]:
                diff = inventory[i] - inventory[i + 1]
                if width * diff <= orders:
                    ans += width * (inventory[i] + inventory[i + 1] + 1) * diff // 2
                    orders -= width * diff
                else:
                    n = orders // width
                    ans += width * (inventory[i] + inventory[i] - n + 1) * n // 2
                    orders -= width * n
                    ans += orders * (inventory[i] - n)
                    orders = 0
                ans %= 1000000007
                if orders == 0:
                    break
                width += 1
        return ans