class Solution:
    def stoneGameII(self, piles: List[int]) -> int:
        n = len(piles)
        memo = {}

        def dp(i, m):
            if i >= n:
                return 0
            if (i, m) in memo:
                return memo[(i, m)]

            total = 0
            max_stones = 0
            for x in range(1, min(2 * m, n - i) + 1):
                total += piles[i + x - 1]
                max_stones = max(max_stones, total - dp(i + x, max(m, x)))

            memo[(i, m)] = max_stones
            return max_stones

        return (sum(piles) + dp(0, 1)) // 2