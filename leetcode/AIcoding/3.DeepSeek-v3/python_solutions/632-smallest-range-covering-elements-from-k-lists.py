import heapq

class Solution:
    def smallestRange(self, nums: List[List[int]]) -> List[int]:
        min_heap = []
        max_val = -float('inf')
        for i in range(len(nums)):
            heapq.heappush(min_heap, (nums[i][0], i, 0))
            max_val = max(max_val, nums[i][0])

        start, end = -float('inf'), float('inf')

        while len(min_heap) == len(nums):
            val, row, col = heapq.heappop(min_heap)
            if max_val - val < end - start:
                start, end = val, max_val

            if col + 1 < len(nums[row]):
                new_val = nums[row][col + 1]
                heapq.heappush(min_heap, (new_val, row, col + 1))
                max_val = max(max_val, new_val)

        return [start, end]