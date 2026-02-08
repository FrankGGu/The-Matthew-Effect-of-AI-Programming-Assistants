import heapq

class Solution:
    def minimumDeviation(self, nums: List[int]) -> int:
        max_heap = []
        min_val = float('inf')

        for num in nums:
            if num % 2 == 1:
                num *= 2
            heapq.heappush(max_heap, -num)
            min_val = min(min_val, num)

        min_deviation = float('inf')

        while True:
            current_max = -heapq.heappop(max_heap)
            min_deviation = min(min_deviation, current_max - min_val)

            if current_max % 2 == 1:
                break

            new_num = current_max // 2
            min_val = min(min_val, new_num)
            heapq.heappush(max_heap, -new_num)

        return min_deviation