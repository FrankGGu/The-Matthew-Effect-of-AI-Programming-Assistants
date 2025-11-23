from typing import List
import heapq

class Solution:
    def minimumSeconds(self, mountain: List[int]) -> int:
        n = len(mountain)
        left = [0] * n
        right = [0] * n
        heap = []

        for i in range(n):
            if mountain[i] == 0:
                left[i] = 0
                heapq.heappush(heap, (0, i))
            else:
                left[i] = float('inf')

        for i in range(n - 1, -1, -1):
            if mountain[i] == 0:
                right[i] = 0
                heapq.heappush(heap, (0, i))
            else:
                right[i] = float('inf')

        while heap:
            time, i = heapq.heappop(heap)
            if i > 0 and left[i - 1] > time + 1:
                left[i - 1] = time + 1
                heapq.heappush(heap, (left[i - 1], i - 1))
            if i < n - 1 and left[i + 1] > time + 1:
                left[i + 1] = time + 1
                heapq.heappush(heap, (left[i + 1], i + 1))

        while heap:
            time, i = heapq.heappop(heap)
            if i > 0 and right[i - 1] > time + 1:
                right[i - 1] = time + 1
                heapq.heappush(heap, (right[i - 1], i - 1))
            if i < n - 1 and right[i + 1] > time + 1:
                right[i + 1] = time + 1
                heapq.heappush(heap, (right[i + 1], i + 1))

        result = float('inf')
        for i in range(n):
            result = min(result, left[i], right[i])

        return result