class Solution:
    def peopleAwareOfSecret(self, n: int, delay: int, forget: int) -> int:
        dp = [0] * (n + 1)
        dp[1] = 1
        shared = [0] * (n + 1)
        shared[1] = 0

        for i in range(2, n + 1):
            shared_today = 0
            for j in range(1, i):
                if i - j >= delay and i - j < forget:
                    shared_today = (shared_today + dp[j]) % (10**9 + 7)
            shared[i] = shared_today
            dp[i] = shared_today

        aware = 0
        for i in range(1, n + 1):
            if n - i < forget:
                aware = (aware + dp[i]) % (10**9 + 7)

        return aware