import heapq

class Solution:
    def maxPerformance(self, n: int, speeds: list[int], efficiencies: list[int], k: int) -> int:
        engineers = []
        for i in range(n):
            engineers.append((efficiencies[i], speeds[i]))

        engineers.sort(key=lambda x: x[0], reverse=True)

        min_heap = []
        current_speed_sum = 0
        max_performance = 0

        for efficiency, speed in engineers:
            heapq.heappush(min_heap, speed)
            current_speed_sum += speed

            if len(min_heap) > k:
                popped_speed = heapq.heappop(min_heap)
                current_speed_sum -= popped_speed

            max_performance = max(max_performance, current_speed_sum * efficiency)

        return max_performance % (10**9 + 7)