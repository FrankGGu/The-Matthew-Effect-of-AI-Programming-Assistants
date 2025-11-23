class Solution:
    def kthSmallest(self, matrix: List[List[int]], k: int) -> int:
        import heapq
        heap = []
        for i in range(len(matrix)):
            heapq.heappush(heap, (matrix[i][0], i, 0))
        count = 0
        while heap:
            val, row, col = heapq.heappop(heap)
            count += 1
            if count == k:
                return val
            if col + 1 < len(matrix):
                heapq.heappush(heap, (matrix[row][col + 1], row, col + 1))