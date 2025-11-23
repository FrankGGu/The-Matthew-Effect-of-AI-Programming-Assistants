import heapq

class Solution:
    def maximizeSum(self, nums: list[int], k: int) -> int:

        max_heap = []
        for num in nums:
            heapq.heappush(max_heap, -num)

        total_score = 0

        for _ in range(k):
            current_max = -heapq.heappop(max_heap)
            total_score += current_max
            heapq.heappush(max_heap, -(current_max + 1))

        return total_score