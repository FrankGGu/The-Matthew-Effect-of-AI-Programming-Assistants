import heapq

class Solution:
    def maxPerformance(self, n: int, speed: List[int], efficiency: List[int], k: int) -> int:
        engineers = sorted(zip(efficiency, speed), reverse=True)
        min_heap = []
        total_speed = 0
        max_performance = 0

        for e, s in engineers:
            if len(min_heap) >= k:
                total_speed -= heapq.heappop(min_heap)
            heapq.heappush(min_heap, s)
            total_speed += s
            max_performance = max(max_performance, total_speed * e)

        return max_performance % (10**9 + 7)