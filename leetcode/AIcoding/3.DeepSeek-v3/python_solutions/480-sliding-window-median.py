import heapq

class Solution:
    def medianSlidingWindow(self, nums: List[int], k: int) -> List[float]:
        max_heap = []
        min_heap = []
        result = []

        for i in range(len(nums)):
            num = nums[i]
            if not max_heap or num <= -max_heap[0][0]:
                heapq.heappush(max_heap, (-num, i))
            else:
                heapq.heappush(min_heap, (num, i))

            while len(max_heap) > len(min_heap) + 1:
                val, idx = heapq.heappop(max_heap)
                heapq.heappush(min_heap, (-val, idx))

            while len(min_heap) > len(max_heap):
                val, idx = heapq.heappop(min_heap)
                heapq.heappush(max_heap, (-val, idx))

            while max_heap and max_heap[0][1] <= i - k:
                heapq.heappop(max_heap)

            while min_heap and min_heap[0][1] <= i - k:
                heapq.heappop(min_heap)

            if i >= k - 1:
                if k % 2 == 1:
                    result.append(-max_heap[0][0])
                else:
                    result.append((-max_heap[0][0] + min_heap[0][0]) / 2)

        return result