class Solution:
    def nthUglyNumber(self, n: int) -> int:
        import heapq
        heap = [1]
        seen = {1}
        factors = [2, 3, 5]
        for _ in range(n - 1):
            current = heapq.heappop(heap)
            for factor in factors:
                next_num = current * factor
                if next_num not in seen:
                    seen.add(next_num)
                    heapq.heappush(heap, next_num)
        return heap[0]