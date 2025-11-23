import heapq

class Solution:
    def maxProfit(self, inventory: List[int], orders: int) -> int:
        MOD = 10**9 + 7
        max_heap = []
        for num in inventory:
            heapq.heappush(max_heap, -num)

        res = 0
        while orders > 0:
            current = -heapq.heappop(max_heap)
            next_val = -max_heap[0] if max_heap else 0
            diff = current - next_val
            count = min(orders, diff * (len(max_heap) + 1))

            full_sets = count // (len(max_heap) + 1)
            remainder = count % (len(max_heap) + 1)

            if full_sets > 0:
                res += (len(max_heap) + 1) * (current + current - full_sets + 1) * full_sets // 2
                res %= MOD
                current -= full_sets
                orders -= full_sets * (len(max_heap) + 1)

            if remainder > 0:
                res += current * remainder
                res %= MOD
                current -= 1
                orders -= remainder

            if current > 0:
                heapq.heappush(max_heap, -current)

        return res % MOD