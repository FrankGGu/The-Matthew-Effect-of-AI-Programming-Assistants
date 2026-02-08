class Solution:
    def countSubmatricesWithEqualXY(self, matrix: List[List[str]], x: str, y: str) -> int:
        if not matrix or not matrix[0]:
            return 0

        m, n = len(matrix), len(matrix[0])
        count = 0

        for top in range(m):
            row_count = [0] * n
            for bottom in range(top, m):
                for col in range(n):
                    if matrix[bottom][col] == x:
                        row_count[col] += 1
                    elif matrix[bottom][col] == y:
                        row_count[col] -= 1

                freq = {}
                curr_sum = 0
                freq[0] = 1

                for value in row_count:
                    curr_sum += value
                    if curr_sum in freq:
                        count += freq[curr_sum]
                        freq[curr_sum] += 1
                    else:
                        freq[curr_sum] = 1

        return count