class Solution:
    def maximumRows(self, matrix: List[List[int]], cols: int) -> int:
        m, n = len(matrix), len(matrix[0])
        ans = 0
        for i in range(1 << n):
            if bin(i).count('1') != cols:
                continue
            covered = 0
            for row in matrix:
                flag = True
                for j in range(n):
                    if row[j] == 1 and (i >> j) & 1 == 0:
                        flag = False
                        break
                if flag:
                    covered += 1
            ans = max(ans, covered)
        return ans