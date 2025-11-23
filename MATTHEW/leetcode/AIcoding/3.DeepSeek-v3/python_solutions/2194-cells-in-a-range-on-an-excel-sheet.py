class Solution:
    def cellsInRange(self, s: str) -> List[str]:
        start_col, start_row, end_col, end_row = s[0], s[1], s[3], s[4]
        result = []
        for col in range(ord(start_col), ord(end_col) + 1):
            for row in range(int(start_row), int(end_row) + 1):
                result.append(chr(col) + str(row))
        return result