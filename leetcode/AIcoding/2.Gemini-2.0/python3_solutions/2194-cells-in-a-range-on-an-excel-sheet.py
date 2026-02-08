class Solution:
    def cellsInRange(self, s: str) -> List[str]:
        start_col = ord(s[0])
        start_row = int(s[1])
        end_col = ord(s[3])
        end_row = int(s[4])

        result = []
        for col in range(start_col, end_col + 1):
            for row in range(start_row, end_row + 1):
                result.append(chr(col) + str(row))

        return result