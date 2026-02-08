class Solution:
    def beautySum(self, s: str) -> int:
        res = 0
        n = len(s)
        for i in range(n):
            freq = [0] * 26
            for j in range(i, n):
                freq[ord(s[j]) - ord('a')] += 1
                max_freq = max(freq)
                min_freq = min(x for x in freq if x > 0)
                res += max_freq - min_freq
        return res