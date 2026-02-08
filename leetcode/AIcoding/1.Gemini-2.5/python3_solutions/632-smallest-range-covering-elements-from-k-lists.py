import heapq

class Solution:
    def smallestRange(self, nums: list[list[int]]) -> list[int]:
        min_heap = []
        current_max = -float('inf')

        for i in range(len(nums)):
            heapq.heappush(min_heap, (nums[i][0], i, 0))
            current_max = max(current_max, nums[i][0])

        range_start = 0
        range_end = float('inf')

        while len(min_heap) == len(nums):
            val, list_idx, element_idx_in_list = heapq.heappop(min_heap)

            if current_max - val < range_end - range_start:
                range_start = val
                range_end = current_max
            elif current_max - val == range_end - range_start:
                if val < range_start:
                    range_start = val
                    range_end = current_max

            if element_idx_in_list + 1 < len(nums[list_idx]):
                next_val = nums[list_idx][element_idx_in_list + 1]
                heapq.heappush(min_heap, (next_val, list_idx, element_idx_in_list + 1))
                current_max = max(current_max, next_val)
            else:
                break

        return [range_start, range_end]