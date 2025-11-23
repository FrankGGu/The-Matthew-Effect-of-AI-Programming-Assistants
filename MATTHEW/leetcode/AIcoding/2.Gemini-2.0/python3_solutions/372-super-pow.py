class Solution:
    def superPow(self, a: int, b: List[int]) -> int:
        MOD = 1337
        def pow_mod(base, exp):
            res = 1
            base %= MOD
            while exp > 0:
                if exp % 2 == 1:
                    res = (res * base) % MOD
                base = (base * base) % MOD
                exp //= 2
            return res

        result = 1
        for digit in b:
            result = pow_mod(result, 10) * pow_mod(a, digit) % MOD
        return result