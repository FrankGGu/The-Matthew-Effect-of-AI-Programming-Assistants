class Solution:
    def leastOpsExpressTarget(self, x: int, target: int) -> int:
        dp = {}

        def solve(num):
            if num == 0:
                return -1, float('inf')
            if num == 1:
                return 0, 0

            if num in dp:
                return dp[num]

            a = num % x
            b = x - a

            if a == 0:
                res1 = 1 + solve(num // x)[0]
                res2 = 1 + solve(num // x)[1]
            elif a == 1:
                res1 = 0, 1 + solve(num // x)[0]
                res2 = 2, 1 + solve(num // x)[1]
            elif a == x - 1:
                res1 = 2, 1 + solve(num // x)[0]
                res2 = 0, 1 + solve(num // x)[1]
            else:
                res1 = a + solve(num // x)[0], a + 2 + solve(num // x)[1]
                res2 = b + solve(num // x + 1)[0], b + solve(num // x + 1)[1]

            dp[num] = min(res1), min(res2)
            return min(res1), min(res2)

        res = solve(target)[0]
        return res