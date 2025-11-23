class Solution:
    def countVowelPermutation(self, n: int) -> int:
        a, e, i, o, u = 1, 1, 1, 1, 1
        mod = 10**9 + 7
        for _ in range(n - 1):
            new_a = (e + i + u) % mod
            new_e = (a + i) % mod
            new_i = (e + o) % mod
            new_o = i % mod
            new_u = (i + o) % mod
            a, e, i, o, u = new_a, new_e, new_i, new_o, new_u
        return (a + e + i + o + u) % mod