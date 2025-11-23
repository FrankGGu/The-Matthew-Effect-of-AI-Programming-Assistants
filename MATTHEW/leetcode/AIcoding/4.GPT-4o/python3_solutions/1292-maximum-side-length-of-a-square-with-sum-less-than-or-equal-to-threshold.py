class Solution:
    def maxSideLength(self, mat: List[List[int]], threshold: int) -> int:
        m, n = len(mat), len(mat[0])
        prefix_sum = [[0] * (n + 1) for _ in range(m + 1)]

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                prefix_sum[i][j] = mat[i - 1][j - 1] + prefix_sum[i - 1][j] + prefix_sum[i][j - 1] - prefix_sum[i - 1][j - 1]

        left, right = 0, min(m, n)
        while left < right:
            mid = (left + right + 1) // 2
            found = False

            for i in range(mid, m + 1):
                for j in range(mid, n + 1):
                    if prefix_sum[i][j] - prefix_sum[i - mid][j] - prefix_sum[i][j - mid] + prefix_sum[i - mid][j - mid] <= threshold:
                        found = True
                        break
                if found:
                    break

            if found:
                left = mid
            else:
                right = mid - 1

        return left