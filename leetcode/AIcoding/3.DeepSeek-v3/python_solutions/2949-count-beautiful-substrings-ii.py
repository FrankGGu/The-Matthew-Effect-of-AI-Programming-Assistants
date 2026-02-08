class Solution:
    def beautifulSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        vowels = {'a', 'e', 'i', 'o', 'u'}
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + (1 if s[i] in vowels else 0)

        res = 0
        mod = 1
        while (mod * mod) % (4 * k) != 0:
            mod += 1

        from collections import defaultdict
        freq = defaultdict(int)
        freq[(0, 0)] = 1

        for i in range(1, n+1):
            v = prefix[i]
            c = i - v
            key = (v - c, v % mod)
            res += freq.get(key, 0)
            freq[key] += 1

        return res