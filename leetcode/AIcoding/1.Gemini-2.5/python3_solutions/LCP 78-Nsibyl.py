import heapq

class Solution:
    def maxPerformance(self, n: int, speed: list[int], efficiency: list[int], k: int) -> int:
        engineers = []
        for i in range(n):
            engineers.append((efficiency[i], speed[i]))

        engineers.sort(key=lambda x: x[0], reverse=True)

        min_heap = []
        current_speed_sum = 0
        max_performance = 0
        MOD = 10**9 + 7

        for eff, spd in engineers:
            heapq.heappush(min_heap, spd)
            current_speed_sum += spd

            if len(min_heap) > k:
                smallest_speed = heapq.heappop(min_heap)
                current_speed_sum -= smallest_speed

            max_performance = max(max_performance, current_speed_sum * eff)

        return max_performance % MOD