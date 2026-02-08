class Solution:
    def numberOfWays(self, corridor: str) -> int:
        MOD = 10**9 + 7
        seats = []
        for i, c in enumerate(corridor):
            if c == 'S':
                seats.append(i)
        n = len(seats)
        if n < 2 or n % 2 != 0:
            return 0
        res = 1
        for i in range(1, n // 2):
            res *= (seats[2 * i] - seats[2 * i - 1])
            res %= MOD
        return res