class Solution:
    def countGoodNumbers(self, n: int) -> int:
        MOD = 10**9 + 7

        even_pos = (n + 1) // 2
        odd_pos = n // 2

        return (pow(5, even_pos, MOD) * pow(4, odd_pos, MOD)) % MOD