import heapq

class Solution:
    def kthSmallest(self, matrix: List[List[int]], k: int) -> int:
        min_heap = []
        n = len(matrix)

        for i in range(min(n, k)):
            heapq.heappush(min_heap, (matrix[i][0], i, 0))

        count = 0
        while count < k:
            val, row, col = heapq.heappop(min_heap)
            count += 1

            if count == k:
                return val

            if col + 1 < len(matrix[row]):
                heapq.heappush(min_heap, (matrix[row][col + 1], row, col + 1))