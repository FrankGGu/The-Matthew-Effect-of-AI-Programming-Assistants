class Solution:
    def maxProfit(self, inventory: List[int], orders: int) -> int:
        inventory.sort(reverse=True)
        MOD = 10**9 + 7
        total = 0
        i = 0
        while orders > 0 and i < len(inventory):
            if i == len(inventory) - 1:
                count = orders
                val = inventory[i]
                total += (val * (val + 1) // 2) - ((val - count) * (val - count + 1) // 2)
                total %= MOD
                orders = 0
            else:
                next_val = inventory[i + 1]
                diff = inventory[i] - next_val
                count = diff * (i + 1)
                if count <= orders:
                    total += (inventory[i] * (inventory[i] + 1) // 2) - (next_val * (next_val + 1) // 2)
                    total %= MOD
                    orders -= count
                    inventory[i] = next_val
                else:
                    full = orders // (i + 1)
                    remainder = orders % (i + 1)
                    total += (inventory[i] * (inventory[i] + 1) // 2) - ((inventory[i] - full) * (inventory[i] - full + 1) // 2)
                    total += (inventory[i] - full) * remainder
                    total %= MOD
                    orders = 0
            i += 1
        return total