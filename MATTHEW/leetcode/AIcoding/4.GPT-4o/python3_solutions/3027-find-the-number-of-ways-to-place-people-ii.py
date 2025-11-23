class Solution:
    def countWays(self, seats: List[int], people: int) -> int:
        MOD = 10**9 + 7

        n = len(seats)
        available = []

        for i in range(n):
            if seats[i] == 0:
                if i == 0 or seats[i - 1] == 0:
                    available.append(1)
                else:
                    available[-1] += 1

        def factorial(x):
            res = 1
            for i in range(2, x + 1):
                res = (res * i) % MOD
            return res

        if people > len(available):
            return 0

        ways = 1
        for i in range(people):
            ways = (ways * available[i]) % MOD

        return (ways * factorial(people)) % MOD