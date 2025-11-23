class Solution:
    def numberOfWays(self, corridor: str) -> int:
        seats = corridor.count('S')
        if seats < 2 or seats % 2 != 0:
            return 0

        MOD = 10**9 + 7

        count = 0
        ways = 1
        plants = 0

        for c in corridor:
            if c == 'S':
                count += 1
                if count > 2 and count % 2 == 1:
                    ways = (ways * (plants + 1)) % MOD
                plants = 0
            elif count >= 2 and count % 2 == 0:
                plants += 1

        return ways