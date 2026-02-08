def solve():
    def min_changes(s, k):
        n = len(s)
        dp = [[float('inf')] * (k + 1) for _ in range(n + 1)]
        dp[0][0] = 0

        def cost(l, r):
            cnt = 0
            while l < r:
                if s[l] != s[r]:
                    cnt += 1
                l += 1
                r -= 1
            return cnt

        for i in range(1, n + 1):
            for j in range(1, min(i, k) + 1):
                for x in range(1, i + 1):
                    dp[i][j] = min(dp[i][j], dp[i - x][j - 1] + cost(i - x, i - 1))

        return dp[n][k]

    n = int(input())
    s = input()
    k = int(input())
    print(min_changes(s, k))

solve()