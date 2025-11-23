import heapq

class Solution:
    def maximumSum(self, nums: List[int], k: int) -> int:
        max_heap = []
        for num in nums:
            heapq.heappush(max_heap, -num)

        max_sum = 0
        for _ in range(k):
            if not max_heap:
                break
            num = -heapq.heappop(max_heap)
            max_sum += num

        return max_sum

    def minimumSum(self, nums: List[int], k: int) -> int:
        min_heap = []
        for num in nums:
            heapq.heappush(min_heap, num)

        min_sum = 0
        for _ in range(k):
            if not min_heap:
                break
            num = heapq.heappop(min_heap)
            min_sum += num

        return min_sum