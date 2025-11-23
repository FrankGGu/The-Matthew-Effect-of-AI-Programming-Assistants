import heapq

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        total = sum(nums)
        half = total / 2
        max_heap = [-x for x in nums]
        heapq.heapify(max_heap)

        operations = 0
        current_sum = total

        while current_sum > half:
            largest = -heapq.heappop(max_heap)
            current_sum -= largest / 2
            heapq.heappush(max_heap, -largest / 2)
            operations += 1

        return operations