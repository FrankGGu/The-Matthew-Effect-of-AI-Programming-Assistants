class Solution:
    def nthUglyNumber(self, n: int) -> int:
        import heapq
        heap = [1]
        seen = {1}
        while len(heap) < n:
            current = heapq.heappop(heap)
            for factor in [2, 3, 5]:
                next_num = current * factor
                if next_num not in seen:
                    seen.add(next_num)
                    heapq.heappush(heap, next_num)
        return heap[0]