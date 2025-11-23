class Solution:
    def countGoodNumbers(self, n: int) -> int:
        MOD = 10**9 + 7
        even_digits = (n + 1) // 2
        odd_digits = n // 2

        result = (pow(5, even_digits, MOD) * pow(4, odd_digits, MOD)) % MOD
        return result