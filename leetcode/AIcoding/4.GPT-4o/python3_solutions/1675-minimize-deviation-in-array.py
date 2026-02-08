import heapq

class Solution:
    def minimumDeviation(self, nums: List[int]) -> int:
        max_heap = []
        min_val = float('inf')

        for num in nums:
            if num % 2 == 0:
                heapq.heappush(max_heap, -num)
                min_val = min(min_val, num)
            else:
                heapq.heappush(max_heap, -num * 2)
                min_val = min(min_val, num * 2)

        min_deviation = float('inf')

        while max_heap:
            max_val = -heapq.heappop(max_heap)
            min_deviation = min(min_deviation, max_val - min_val)
            if max_val % 2 == 0:
                min_val = min(min_val, max_val // 2)
                heapq.heappush(max_heap, -max_val // 2)
            else:
                break

        return min_deviation