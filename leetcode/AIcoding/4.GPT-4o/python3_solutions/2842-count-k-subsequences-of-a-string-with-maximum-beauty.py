class Solution:
    def countKSubsequences(self, s: str, k: int) -> int:
        from collections import Counter
        mod = 10**9 + 7

        count = Counter(s)
        freq = list(count.values())

        if len(freq) < k:
            return 0

        freq.sort(reverse=True)
        if k == 1:
            return sum(freq) % mod

        total = 1
        for i in range(k):
            total *= freq[i]
            total %= mod

        return total