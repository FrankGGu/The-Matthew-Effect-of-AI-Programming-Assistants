class Solution:
    def goodSubsetofBinaryMatrix(self, matrix: List[List[int]]) -> List[int]:
        m = len(matrix)
        n = len(matrix[0])

        for i in range(m):
            if all(x == 0 for x in matrix[i]):
                return [i]

        seen = {}
        for i in range(m):
            val = 0
            for j in range(n):
                if matrix[i][j] == 1:
                    val += (1 << j)
            seen[i] = val

        for i in range(m):
            for j in range(i + 1, m):
                if (seen[i] | seen[j]) == seen[i] ^ seen[j]:
                    return [i, j]

        return []