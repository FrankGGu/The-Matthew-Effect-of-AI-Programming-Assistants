import heapq

class Solution:
    def maximumRobots(self, chargeTimes: List[int], runningCosts: List[int], budget: int) -> int:
        n = len(chargeTimes)
        left = 0
        current_sum = 0
        max_heap = []
        max_len = 0

        for right in range(n):
            current_sum += runningCosts[right]
            heapq.heappush(max_heap, (-chargeTimes[right], right))

            while max_heap and (-max_heap[0][0] + (right - left + 1) * current_sum) > budget:
                current_sum -= runningCosts[left]
                left += 1
                while max_heap and max_heap[0][1] < left:
                    heapq.heappop(max_heap)

            max_len = max(max_len, right - left + 1)

        return max_len