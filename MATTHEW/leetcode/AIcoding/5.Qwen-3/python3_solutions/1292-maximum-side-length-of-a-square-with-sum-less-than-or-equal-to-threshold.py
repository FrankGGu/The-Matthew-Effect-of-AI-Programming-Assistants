class Solution:
    def maxSideLength(self, mat: List[List[int]], threshold: int) -> int:
        import bisect
        m, n = len(mat), len(mat[0])
        prefix = [[0] * (n + 1) for _ in range(m + 1)]
        for i in range(m):
            for j in range(n):
                prefix[i + 1][j + 1] = mat[i][j] + prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j]

        def get_sum(x1, y1, x2, y2):
            return prefix[x2][y2] - prefix[x1][y2] - prefix[x2][y1] + prefix[x1][y1]

        left, right = 1, min(m, n)
        result = 0
        while left <= right:
            mid = (left + right) // 2
            found = False
            for i in range(m - mid + 1):
                for j in range(n - mid + 1):
                    total = get_sum(i, j, i + mid, j + mid)
                    if total <= threshold:
                        found = True
                        break
                if found:
                    break
            if found:
                result = mid
                left = mid + 1
            else:
                right = mid - 1
        return result