class Solution:
    def matrixScore(self, A: List[List[int]]) -> int:
        m = len(A)
        n = len(A[0])

        for i in range(m):
            if A[i][0] == 0:
                for j in range(n):
                    A[i][j] = 1 - A[i][j]

        for j in range(1, n):
            count = 0
            for i in range(m):
                if A[i][j] == 0:
                    count += 1

            if count > m // 2:
                for i in range(m):
                    A[i][j] = 1 - A[i][j]

        ans = 0
        for i in range(m):
            num = 0
            for j in range(n):
                num = num * 2 + A[i][j]
            ans += num

        return ans