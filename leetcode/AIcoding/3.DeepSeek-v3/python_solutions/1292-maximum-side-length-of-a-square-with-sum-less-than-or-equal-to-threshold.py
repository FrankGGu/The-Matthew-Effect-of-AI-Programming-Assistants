class Solution:
    def maxSideLength(self, mat: List[List[int]], threshold: int) -> int:
        m, n = len(mat), len(mat[0])
        prefix = [[0] * (n + 1) for _ in range(m + 1)]

        for i in range(1, m + 1):
            for j in range(1, n + 1):
                prefix[i][j] = mat[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]

        def get_sum(x1, y1, x2, y2):
            return prefix[x2][y2] - prefix[x1-1][y2] - prefix[x2][y1-1] + prefix[x1-1][y1-1]

        max_len = 0
        for i in range(1, m + 1):
            for j in range(1, n + 1):
                low, high = 1, min(m - i + 1, n - j + 1)
                while low <= high:
                    mid = (low + high) // 2
                    total = get_sum(i, j, i + mid - 1, j + mid - 1)
                    if total <= threshold:
                        max_len = max(max_len, mid)
                        low = mid + 1
                    else:
                        high = mid - 1
        return max_len