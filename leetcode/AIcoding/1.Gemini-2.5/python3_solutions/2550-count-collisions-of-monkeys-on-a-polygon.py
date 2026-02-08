class Solution:
    def monkeyMove(self, n: int) -> int:
        MOD = 10**9 + 7
        total_ways = pow(2, n, MOD)
        collision_ways = (total_ways - 2 + MOD) % MOD
        return collision_ways