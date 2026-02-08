MOD = 10**9 + 7

class Solution:
    def countGoodNumbers(self, n: int) -> int:
        even = (n + 1) // 2
        odd = n // 2

        def pow_mod(x, power):
            res = 1
            while power > 0:
                if power % 2 == 1:
                    res = (res * x) % MOD
                x = (x * x) % MOD
                power = power // 2
            return res

        return (pow_mod(5, even) * pow_mod(4, odd)) % MOD