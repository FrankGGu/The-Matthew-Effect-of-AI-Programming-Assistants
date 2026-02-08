import heapq

class Solution:
    def smallestRange(self, nums: list[list[int]]) -> list[int]:
        k = len(nums)
        pq = []
        max_val = float('-inf')
        for i in range(k):
            heapq.heappush(pq, (nums[i][0], i, 0))
            max_val = max(max_val, nums[i][0])

        range_start = -10**9
        range_end = 10**9

        while pq:
            min_val, list_idx, element_idx = heapq.heappop(pq)

            if max_val - min_val < range_end - range_start:
                range_start = min_val
                range_end = max_val

            if element_idx + 1 < len(nums[list_idx]):
                new_val = nums[list_idx][element_idx + 1]
                max_val = max(max_val, new_val)
                heapq.heappush(pq, (new_val, list_idx, element_idx + 1))
            else:
                break

        return [range_start, range_end]