import heapq

class Solution:
    def kthSmallest(self, matrix: list[list[int]], k: int) -> int:
        n = len(matrix)
        heap = [(matrix[0][0], 0, 0)]
        visited = set()
        visited.add((0, 0))

        for _ in range(k):
            val, row, col = heapq.heappop(heap)

            if row + 1 < n and (row + 1, col) not in visited:
                heapq.heappush(heap, (matrix[row + 1][col], row + 1, col))
                visited.add((row + 1, col))

            if col + 1 < n and (row, col + 1) not in visited:
                heapq.heappush(heap, (matrix[row][col + 1], row, col + 1))
                visited.add((row, col + 1))

        return val