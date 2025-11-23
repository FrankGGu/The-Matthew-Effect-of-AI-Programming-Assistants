import heapq

class Solution:
    def maxProfit(self, inventory: list[int], orders: int) -> int:
        inventory = [-x for x in inventory]
        heapq.heapify(inventory)
        ans = 0
        mod = 10**9 + 7
        while orders > 0:
            curr = -heapq.heappop(inventory)
            if inventory:
                nxt = -inventory[0]
            else:
                nxt = 0
            diff = curr - nxt
            if diff * (heapq.nsmallest(1, [orders])[0] // diff) <= orders:
                take = min(orders // diff, 10**9)
                ans += (curr + curr - diff + 1) * diff // 2 * take
                ans %= mod
                orders -= diff * take
                heapq.heappush(inventory, -(curr - diff))
            else:
                take = orders
                ans += (curr + curr - orders + 1) * orders // 2
                ans %= mod
                orders = 0
        return ans