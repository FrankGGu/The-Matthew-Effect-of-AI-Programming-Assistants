class Solution:
    def distinctSequences(self, n: int) -> int:
        MOD = 10**9 + 7
        dp = {}

        def solve(length, prev, second_prev):
            if length == n:
                return 1

            if (length, prev, second_prev) in dp:
                return dp[(length, prev, second_prev)]

            count = 0
            for i in range(1, 7):
                if i != prev and i != second_prev and (prev == 0 or self.gcd(prev, i) == 1):
                    count = (count + solve(length + 1, i, prev)) % MOD

            dp[(length, prev, second_prev)] = count
            return count

        def gcd(a, b):
            if b == 0:
                return a
            return gcd(b, a % b)

        return solve(0, 0, 0)