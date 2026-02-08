class Solution:
    def makeStringSorted(self, s: str) -> int:
        n = len(s)
        arr = list(s)
        mod = 10**9 + 7
        fact = [1] * (n + 1)
        for i in range(1, n + 1):
            fact[i] = (fact[i - 1] * i) % mod

        def modInverse(n, mod):
            return pow(n, mod - 2, mod)

        ans = 0
        for i in range(n):
            smaller = 0
            for j in range(i + 1, n):
                if arr[j] < arr[i]:
                    smaller += 1

            denom = {}
            for j in range(i, n):
                if arr[j] not in denom:
                    denom[arr[j]] = 0
                denom[arr[j]] += 1

            denom_prod = 1
            for val in denom.values():
                denom_prod = (denom_prod * fact[val]) % mod

            ans = (ans + smaller * fact[n - i - 1] * modInverse(denom_prod, mod)) % mod
        return int(ans)