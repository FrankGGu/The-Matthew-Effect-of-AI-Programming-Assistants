class Solution:
    def spiralMatrix(self, m: int, n: int, head: ListNode) -> List[List[int]]:
        matrix = [[-1] * n for _ in range(m)]
        row_start, row_end = 0, m - 1
        col_start, col_end = 0, n - 1

        curr = head

        while row_start <= row_end and col_start <= col_end and curr:
            # Traverse right
            for j in range(col_start, col_end + 1):
                if curr:
                    matrix[row_start][j] = curr.val
                    curr = curr.next
                else:
                    break
            row_start += 1
            if not curr:
                break

            # Traverse down
            for i in range(row_start, row_end + 1):
                if curr:
                    matrix[i][col_end] = curr.val
                    curr = curr.next
                else:
                    break
            col_end -= 1
            if not curr:
                break

            # Traverse left
            if row_start <= row_end and col_start <= col_end:
                for j in range(col_end, col_start - 1, -1):
                    if curr:
                        matrix[row_end][j] = curr.val
                        curr = curr.next
                    else:
                        break
                row_end -= 1
                if not curr:
                    break

            # Traverse up
            if row_start <= row_end and col_start <= col_end:
                for i in range(row_end, row_start - 1, -1):
                    if curr:
                        matrix[i][col_start] = curr.val
                        curr = curr.next
                    else:
                        break
                col_start += 1
                if not curr:
                    break

        return matrix