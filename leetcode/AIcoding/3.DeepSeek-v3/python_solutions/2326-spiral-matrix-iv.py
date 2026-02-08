class Solution:
    def spiralMatrix(self, m: int, n: int, head: Optional[ListNode]) -> List[List[int]]:
        matrix = [[-1 for _ in range(n)] for _ in range(m)]
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        direction = 0
        row, col = 0, 0

        current = head
        while current:
            matrix[row][col] = current.val
            current = current.next

            next_row = row + directions[direction][0]
            next_col = col + directions[direction][1]

            if 0 <= next_row < m and 0 <= next_col < n and matrix[next_row][next_col] == -1:
                row, col = next_row, next_col
            else:
                direction = (direction + 1) % 4
                row += directions[direction][0]
                col += directions[direction][1]

        return matrix