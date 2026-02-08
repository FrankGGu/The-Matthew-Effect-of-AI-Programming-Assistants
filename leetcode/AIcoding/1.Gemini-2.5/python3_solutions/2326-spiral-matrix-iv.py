from typing import Optional, List

class Solution:
    def spiralMatrix(self, m: int, n: int, head: Optional[ListNode]) -> List[List[int]]:
        matrix = [[-1] * n for _ in range(m)]

        top, bottom = 0, m - 1
        left, right = 0, n - 1

        while top <= bottom and left <= right and head:
            # Traverse Right
            for c in range(left, right + 1):
                if not head:
                    break
                matrix[top][c] = head.val
                head = head.next
            top += 1
            if not head:
                break

            # Traverse Down
            for r in range(top, bottom + 1):
                if not head:
                    break
                matrix[r][right] = head.val
                head = head.next
            right -= 1
            if not head:
                break

            # Traverse Left
            if top <= bottom: # Ensure there's a row to traverse
                for c in range(right, left - 1, -1):
                    if not head:
                        break
                    matrix[bottom][c] = head.val
                    head = head.next
                bottom -= 1
                if not head:
                    break

            # Traverse Up
            if left <= right: # Ensure there's a column to traverse
                for r in range(bottom, top - 1, -1):
                    if not head:
                        break
                    matrix[r][left] = head.val
                    head = head.next
                left += 1
                if not head:
                    break

        return matrix