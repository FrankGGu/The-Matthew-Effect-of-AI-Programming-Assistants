class Solution:
    def makeStringSorted(self, s: str) -> int:
        mod = 10**9 + 7
        n = len(s)
        fact = [1] * (n + 1)
        inv_fact = [1] * (n + 1)

        for i in range(1, n + 1):
            fact[i] = fact[i - 1] * i % mod

        inv_fact[n] = pow(fact[n], mod - 2, mod)
        for i in range(n - 1, -1, -1):
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % mod

        res = 0
        freq = [0] * 26
        for i in range(n - 1, -1, -1):
            c = ord(s[i]) - ord('a')
            freq[c] += 1
            t = sum(freq[:c])
            temp = t * fact[n - i - 1] % mod
            for k in range(26):
                if freq[k] > 1:
                    temp = temp * inv_fact[freq[k]] % mod
            res = (res + temp) % mod
        return res