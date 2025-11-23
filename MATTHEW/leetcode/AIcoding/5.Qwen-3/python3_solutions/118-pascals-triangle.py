class Solution:
    def generate(self, numRows: int) -> List[List[int]]:
        result = []
        for i in range(numRows):
            row = [1]
            if i > 0:
                for j in range(1, i):
                    row.append(result[i-1][j-1] + result[i-1][j])
                row.append(1)
            result.append(row)
        return result