class Solution:
    def monkeyMove(self, n: int) -> bool:
        MOD = 10**9 + 7
        def pow_mod(a, b):
            result = 1
            a = a % MOD
            while b > 0:
                if b % 2 == 1:
                    result = (result * a) % MOD
                a = (a * a) % MOD
                b = b // 2
            return result
        return pow_mod(2, n) != 2