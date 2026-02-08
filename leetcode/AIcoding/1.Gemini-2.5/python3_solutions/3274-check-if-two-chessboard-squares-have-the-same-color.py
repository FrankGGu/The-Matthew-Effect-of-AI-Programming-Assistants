class Solution:
    def squareIsWhite(self, coordinates: str) -> bool:
        col_idx = ord(coordinates[0]) - ord('a') + 1
        row_idx = int(coordinates[1])

        return (col_idx + row_idx) % 2 == 1