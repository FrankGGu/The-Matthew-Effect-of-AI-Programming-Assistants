import heapq

class Solution:
    def halveArray(self, nums: List[int]) -> int:
        total = sum(nums)
        target = total / 2
        heap = []
        for num in nums:
            heapq.heappush(heap, -num)

        operations = 0
        reduced = 0.0
        while reduced < target:
            current = -heapq.heappop(heap)
            half = current / 2
            reduced += half
            heapq.heappush(heap, -(current - half))
            operations += 1

        return operations