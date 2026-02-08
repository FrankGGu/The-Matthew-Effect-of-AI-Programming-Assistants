class Solution:
    def countWays(self, numPeople: int, numBoys: int, numGirls: int) -> int:
        mod = 10**9 + 7

        def factorial(n):
            if n == 0 or n == 1:
                return 1
            res = 1
            for i in range(2, n + 1):
                res = (res * i) % mod
            return res

        if numBoys + numGirls < numPeople:
            return 0

        total_ways = factorial(numBoys) * factorial(numGirls) % mod
        total_ways = total_ways * factorial(numPeople) % mod
        return total_ways