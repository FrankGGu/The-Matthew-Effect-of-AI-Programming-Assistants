import heapq

class Solution:
    def maximizeSum(self, nums: List[int], k: int) -> int:
        max_heap = []
        for num in nums:
            heapq.heappush(max_heap, -num)

        total = 0
        for _ in range(k):
            if not max_heap:
                break
            current = -heapq.heappop(max_heap)
            total += current
            heapq.heappush(max_heap, -(current - 1))

        return total