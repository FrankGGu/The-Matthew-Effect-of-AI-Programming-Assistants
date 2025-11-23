class Solution:
    def numOfWays(self, n: int) -> int:
        MOD = 10**9 + 7
        if n == 0:
            return 0
        # For the first row, there are 12 possible patterns (6 of type ABA and 6 of type ABC)
        aba = 6
        abc = 6
        for _ in range(1, n):
            new_aba = (3 * aba + 2 * abc) % MOD
            new_abc = (2 * aba + 2 * abc) % MOD
            aba, abc = new_aba, new_abc
        return (aba + abc) % MOD