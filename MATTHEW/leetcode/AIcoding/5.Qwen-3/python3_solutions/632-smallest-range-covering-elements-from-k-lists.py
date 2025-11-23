import heapq

class Solution:
    def smallestRange(self, lists):
        min_heap = []
        max_val = -float('inf')

        for i, lst in enumerate(lists):
            if lst:
                heapq.heappush(min_heap, (lst[0], i, 0))
                max_val = max(max_val, lst[0])

        range_start = -float('inf')
        range_end = float('inf')

        while min_heap:
            curr_val, list_idx, element_idx = heapq.heappop(min_heap)
            current_range = max_val - curr_val
            if current_range < (range_end - range_start):
                range_start = curr_val
                range_end = max_val

            if element_idx + 1 < len(lists[list_idx]):
                next_val = lists[list_idx][element_idx + 1]
                heapq.heappush(min_heap, (next_val, list_idx, element_idx + 1))
                max_val = max(max_val, next_val)
            else:
                break

        return [range_start, range_end]