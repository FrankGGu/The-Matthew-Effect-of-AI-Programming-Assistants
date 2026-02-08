import heapq

class Solution:
    def maxPerformance(self, n: int, speed: list[int], efficiency: list[int], k: int) -> int:
        engineers = sorted(zip(efficiency, speed), reverse=True)
        heap = []
        total_speed = 0
        max_performance = 0

        for eff, spd in engineers:
            heapq.heappush(heap, spd)
            total_speed += spd

            if len(heap) > k:
                total_speed -= heapq.heappop(heap)

            max_performance = max(max_performance, total_speed * eff)

        return max_performance % (10**9 + 7)