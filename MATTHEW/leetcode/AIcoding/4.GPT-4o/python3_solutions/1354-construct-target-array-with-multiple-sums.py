import heapq

class Solution:
    def isPossible(self, target: List[int]) -> bool:
        total_sum = sum(target)
        max_heap = [-x for x in target]
        heapq.heapify(max_heap)

        while True:
            largest = -heapq.heappop(max_heap)
            total_sum -= largest

            if largest == 1 or total_sum == 1:
                return True
            if total_sum == 0 or largest <= total_sum:
                return False

            largest %= total_sum
            total_sum += largest
            heapq.heappush(max_heap, -largest)