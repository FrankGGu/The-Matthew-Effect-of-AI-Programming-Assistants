class Solution:
    def squareIsWhite(self, coordinates: str) -> bool:
        col_num = ord(coordinates[0]) - ord('a') + 1
        row_num = int(coordinates[1])

        # A square is white if the sum of its 1-indexed column and row numbers is odd.
        # A square is black if the sum of its 1-indexed column and row numbers is even.
        # (Given A1 is black, 1+1=2 is even, so even sum is black, odd sum is white)

        return (col_num + row_num) % 2 == 1