class Solution:
    def beautySum(self, s: str) -> int:
        n = len(s)
        ans = 0
        for i in range(n):
            freq = {}
            for j in range(i, n):
                freq[s[j]] = freq.get(s[j], 0) + 1
                max_freq = 0
                min_freq = float('inf')
                for char in freq:
                    max_freq = max(max_freq, freq[char])
                    min_freq = min(min_freq, freq[char])
                ans += max_freq - min_freq
        return ans