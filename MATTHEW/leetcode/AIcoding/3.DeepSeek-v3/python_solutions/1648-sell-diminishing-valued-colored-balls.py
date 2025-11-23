class Solution:
    def maxProfit(self, inventory: List[int], orders: int) -> int:
        inventory.sort(reverse=True)
        inventory.append(0)
        res = 0
        k = 1
        mod = 10**9 + 7

        for i in range(len(inventory)-1):
            if inventory[i] > inventory[i+1]:
                if k * (inventory[i] - inventory[i+1]) < orders:
                    res += k * (inventory[i] + inventory[i+1] + 1) * (inventory[i] - inventory[i+1]) // 2
                    orders -= k * (inventory[i] - inventory[i+1])
                else:
                    q = orders // k
                    res += k * (inventory[i] + inventory[i] - q + 1) * q // 2
                    remaining = orders % k
                    res += remaining * (inventory[i] - q)
                    res %= mod
                    return res
                res %= mod
            k += 1

        return res % mod