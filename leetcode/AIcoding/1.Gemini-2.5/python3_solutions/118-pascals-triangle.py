class Solution:
    def generate(self, numRows: int) -> list[list[int]]:
        result = []
        for i in range(numRows):
            current_row = []
            if i == 0:
                current_row = [1]
            else:
                prev_row = result[i - 1]
                current_row.append(1)
                for j in range(1, i):
                    current_row.append(prev_row[j - 1] + prev_row[j])
                current_row.append(1)
            result.append(current_row)
        return result