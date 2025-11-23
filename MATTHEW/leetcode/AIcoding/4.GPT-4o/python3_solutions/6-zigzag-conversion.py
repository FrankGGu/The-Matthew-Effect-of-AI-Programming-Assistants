class Solution:
    def convert(self, s: str, numRows: int) -> str:
        if numRows == 1 or numRows >= len(s):
            return s

        rows = [''] * numRows
        cur_row = 0
        going_down = False

        for char in s:
            rows[cur_row] += char
            if cur_row == 0:
                going_down = True
            elif cur_row == numRows - 1:
                going_down = False
            cur_row += 1 if going_down else -1

        return ''.join(rows)