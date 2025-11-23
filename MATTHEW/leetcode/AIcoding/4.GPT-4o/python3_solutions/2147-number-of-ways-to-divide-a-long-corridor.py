class Solution:
    def countWays(self, corridor: str) -> int:
        MOD = 10**9 + 7
        seats = corridor.split('|')
        if len(seats) < 2 or len(seats[0]) % 2 != 0:
            return 0

        ways = len(seats[0]) // 2
        for i in range(1, len(seats) - 1):
            if len(seats[i]) % 2 != 0:
                return 0
            ways += len(seats[i]) // 2

        if len(seats[-1]) % 2 != 0:
            return 0

        ways += len(seats[-1]) // 2
        return pow(2, ways - 1, MOD)