class Solution:
    def longestVShape(self, matrix: List[List[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        max_len = 0

        for r in range(rows):
            for c in range(cols):
                current = 1
                dr, dc = -1, 1
                while 0 <= r + dr < rows and 0 <= c + dc < cols:
                    if matrix[r + dr][c + dc] == matrix[r] and matrix[r + dr][c + dc] == matrix[r + dr][c + dc]:
                        current += 1
                        dr -= 1
                        dc += 1
                    else:
                        break
                dr, dc = 1, 1
                while 0 <= r + dr < rows and 0 <= c + dc < cols:
                    if matrix[r + dr][c + dc] == matrix[r] and matrix[r + dr][c + dc] == matrix[r + dr][c + dc]:
                        current += 1
                        dr += 1
                        dc += 1
                    else:
                        break
                max_len = max(max_len, current)

        return max_len