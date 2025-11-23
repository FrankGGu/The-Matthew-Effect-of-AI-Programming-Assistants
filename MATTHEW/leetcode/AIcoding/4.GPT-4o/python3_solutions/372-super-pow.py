class Solution:
    def superPow(self, a: int, b: List[int]) -> int:
        MOD = 1337
        a %= MOD

        def powmod(x, n):
            if n == 0:
                return 1
            half = powmod(x, n // 2)
            if n % 2 == 0:
                return (half * half) % MOD
            else:
                return (half * half * x) % MOD

        result = 1
        for digit in b:
            result = (result * powmod(a, digit)) % MOD
            a = powmod(a, 10)

        return result