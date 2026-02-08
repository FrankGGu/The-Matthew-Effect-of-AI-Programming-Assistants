class Solution:
    def rowAndMaximumOnes(self, mat: list[list[int]]) -> list[int]:
        max_ones = -1
        result_row_index = -1

        for i, row in enumerate(mat):
            current_ones = sum(row)
            if current_ones > max_ones:
                max_ones = current_ones
                result_row_index = i
            # If current_ones == max_ones, we keep the smaller row index
            # which is naturally handled by iterating from i=0 upwards.

        return [result_row_index, max_ones]