class Solution:
    def solve(self, A, B):
        m = len(A)
        n = len(A[0])

        prefix_xor = {}

        def dfs(i, j, current_xor):
            if i < 0 or i >= m or j < 0 or j >= n:
                return 0

            current_xor ^= A[i][j]

            if i == m - 1 and j == n - 1:
                return 1 if current_xor == B else 0

            key = (i, j, current_xor)

            if key in prefix_xor:
                return prefix_xor[key]

            result = dfs(i + 1, j, current_xor) + dfs(i, j + 1, current_xor)

            prefix_xor[key] = result

            return result

        return dfs(0, 0, 0)