from typing import List
import heapq

class Solution:
    def minAbsoluteDifference(self, matrix: List[List[int]]) -> int:
        rows, cols = len(matrix), len(matrix[0])
        min_heap = []
        for i in range(3):
            for j in range(3):
                heapq.heappush(min_heap, (matrix[i][j], i, j))

        result = float('inf')
        for i in range(rows - 2):
            for j in range(cols - 2):
                current = []
                for x in range(i, i + 3):
                    for y in range(j, j + 3):
                        current.append(matrix[x][y])
                current.sort()
                for k in range(1, 9):
                    result = min(result, current[k] - current[k - 1])
                if i == 0 and j == 0:
                    for _ in range(9):
                        heapq.heappop(min_heap)
                    for x in range(3):
                        for y in range(3):
                            heapq.heappush(min_heap, (matrix[x][y], x, y))
                else:
                    for x in range(i, i + 3):
                        for y in range(j, j + 3):
                            if x == i and y == j:
                                continue
                            heapq.heappush(min_heap, (matrix[x][y], x, y))
                    for x in range(i, i + 3):
                        for y in range(j, j + 3):
                            if x == i and y == j:
                                continue
                            heapq.heappop(min_heap)
        return result