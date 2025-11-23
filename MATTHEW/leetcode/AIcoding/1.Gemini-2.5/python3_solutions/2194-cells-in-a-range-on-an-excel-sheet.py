class Solution:
    def cellsInRange(self, s: str) -> list[str]:
        start_col_char = s[0]
        start_row_int = int(s[1])
        end_col_char = s[3]
        end_row_int = int(s[4])

        result = []

        for col_code in range(ord(start_col_char), ord(end_col_char) + 1):
            current_col_char = chr(col_code)
            for row_num in range(start_row_int, end_row_int + 1):
                cell_name = current_col_char + str(row_num)
                result.append(cell_name)

        return result