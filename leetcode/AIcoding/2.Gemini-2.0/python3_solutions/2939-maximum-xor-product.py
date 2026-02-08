class Solution:
    def maximumXorProduct(self, a: int, b: int, n: int) -> int:
        MOD = 10**9 + 7
        if (a >> n) == (b >> n) == 0:
            x = (1 << n) - 1
            return ((a ^ x) % MOD) * ((b ^ x) % MOD) % MOD

        ans = 0

        if a > b:
            a, b = b, a

        x = 0

        for i in range(n - 1, -1, -1):
            if (a >> i) & 1 == 0 and (b >> i) & 1 == 0:
                x |= (1 << i)
            elif (a >> i) & 1 == 0 and (b >> i) & 1 == 1:
                if a + (1 << i) > b - (1 << i):
                    x |= (1 << i)
                else:
                    pass
            else:
                pass

        ans = (a ^ x) * (b ^ x)

        return ans % MOD