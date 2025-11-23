class Solution:
    def isValidSudoku(self, board: list[list[str]]) -> bool:
        rows = [set() for _ in range(9)]
        cols = [set() for _ in range(9)]
        boxes = [set() for _ in range(9)]

        for r in range(9):
            for c in range(9):
                char = board[r][c]
                if char != '.':
                    box_idx = (r // 3) * 3 + (c // 3)

                    if char in rows[r]:
                        return False
                    if char in cols[c]:
                        return False
                    if char in boxes[box_idx]:
                        return False

                    rows[r].add(char)
                    cols[c].add(char)
                    boxes[box_idx].add(char)

        return True