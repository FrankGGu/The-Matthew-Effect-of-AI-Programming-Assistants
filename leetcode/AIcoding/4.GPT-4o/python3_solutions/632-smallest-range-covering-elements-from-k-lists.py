import heapq

def smallestRange(nums):
    min_heap = []
    current_max = float('-inf')

    for i, lst in enumerate(nums):
        heapq.heappush(min_heap, (lst[0], i, 0))
        current_max = max(current_max, lst[0])

    range_start, range_end = -10**5, 10**5

    while min_heap:
        current_min, list_index, element_index = heapq.heappop(min_heap)

        if current_max - current_min < range_end - range_start:
            range_start, range_end = current_min, current_max

        if element_index + 1 == len(nums[list_index]):
            break

        next_element = nums[list_index][element_index + 1]
        heapq.heappush(min_heap, (next_element, list_index, element_index + 1))
        current_max = max(current_max, next_element)

    return [range_start, range_end]