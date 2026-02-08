import heapq

class Solution:
    def maxKelements(self, nums: List[int], k: int) -> int:
        max_heap = []
        for num in nums:
            heapq.heappush(max_heap, -num)

        total = 0
        for _ in range(k):
            current = -heapq.heappop(max_heap)
            total += current
            new_num = (current + 2) // 3
            heapq.heappush(max_heap, -new_num)

        return total