import heapq

class Solution:
    def minArrayLength(self, nums: List[int]) -> int:
        counts = {}
        for num in nums:
            counts[num] = counts.get(num, 0) + 1

        heap = [-count for count in counts.values()]
        heapq.heapify(heap)

        while len(heap) > 1:
            x = -heapq.heappop(heap)
            y = -heapq.heappop(heap)

            if x > 1:
                heapq.heappush(heap, -(x - 1))
            if y > 1:
                heapq.heappush(heap, -(y - 1))

        if heap:
            return -heapq.heappop(heap)
        else:
            return 0