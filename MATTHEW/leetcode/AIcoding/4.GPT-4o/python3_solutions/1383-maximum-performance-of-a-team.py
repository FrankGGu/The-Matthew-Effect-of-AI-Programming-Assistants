class Solution:
    def maxPerformance(self, n: int, speed: List[int], efficiency: List[int], k: int) -> int:
        engineers = sorted(zip(efficiency, speed), reverse=True)
        max_perf = 0
        speed_heap = []
        total_speed = 0

        for eff, spd in engineers:
            if len(speed_heap) == k:
                total_speed -= heappop(speed_heap)
            total_speed += spd
            heappush(speed_heap, spd)
            max_perf = max(max_perf, total_speed * eff)

        return max_perf % (10**9 + 7)