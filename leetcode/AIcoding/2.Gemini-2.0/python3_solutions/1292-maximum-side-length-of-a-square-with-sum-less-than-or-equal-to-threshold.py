class Solution:
    def maxSideLength(self, mat: List[List[int]], threshold: int) -> int:
        m, n = len(mat), len(mat[0])
        prefix_sum = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                prefix_sum[i][j] = prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1] + mat[i - 1][j - 1]

        def get_sum(r1, c1, r2, c2):
            return prefix_sum[r2][c2] - prefix_sum[r1 - 1][c2] - prefix_sum[r2][c1 - 1] + prefix_sum[r1 - 1][c1 - 1]

        left, right = 0, min(m, n)
        ans = 0
        while left <= right:
            mid = (left + right) // 2
            found = False
            for i in range(1, m - mid + 2):
                for j in range(1, n - mid + 2):
                    if get_sum(i, j, i + mid - 1, j + mid - 1) <= threshold:
                        found = True
                        break
                if found:
                    break
            if found:
                ans = mid
                left = mid + 1
            else:
                right = mid - 1
        return ans