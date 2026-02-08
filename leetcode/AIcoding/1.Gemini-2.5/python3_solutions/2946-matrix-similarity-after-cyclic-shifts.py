class Solution:
    def areSimilar(self, mat: list[list[int]], k: int) -> bool:
        R = len(mat)
        C = len(mat[0])

        for i in range(R):
            original_row = mat[i]
            shift_amount = k % C

            if i % 2 == 0:  # Even-indexed row, shift right
                shifted_row = original_row[C - shift_amount:] + original_row[:C - shift_amount]
            else:  # Odd-indexed row, shift left
                shifted_row = original_row[shift_amount:] + original_row[:shift_amount]

            if original_row != shifted_row:
                return False

        return True