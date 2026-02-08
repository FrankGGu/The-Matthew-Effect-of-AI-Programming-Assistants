import heapq

class Solution:
    def findKthLargest(self, nums: list[int], k: int) -> int:
        # Use a min-heap of size k
        # The heap will store the k largest elements encountered so far
        # The smallest element in the heap (heap[0]) will be the Kth largest

        min_heap = []

        for num in nums:
            if len(min_heap) < k:
                heapq.heappush(min_heap, num)
            elif num > min_heap[0]:
                heapq.heapreplace(min_heap, num)

        return min_heap[0]