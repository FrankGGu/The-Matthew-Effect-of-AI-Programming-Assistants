class Solution:
    def paintingPlan(self, n: int, k: int) -> int:
        if k < 0 or k > n * n:
            return 0
        if n == 0:
            return 1 if k == 0 else 0
        if n == 1:
            return 1 if k <= 1 else 0
        if k == 0:
            return 1
        if k == n * n:
            return 1

        ans = 0
        for row in range(n + 1):
            col = (k - row * n) / (n - row) if n - row != 0 else float('inf')
            if col == int(col) and 0 <= col <= n and row + col <= n and row * n + col * n - row * col == k:
                def combinations(n, k):
                    if k < 0 or k > n:
                        return 0
                    if k == 0 or k == n:
                        return 1
                    if k > n // 2:
                        k = n - k
                    res = 1
                    for i in range(k):
                        res = res * (n - i) // (i + 1)
                    return res
                ans += combinations(n, row) * combinations(n, int(col))

        return ans