class Solution:
    def beautySum(self, s: str) -> int:
        total = 0
        n = len(s)

        for i in range(n):
            freq = [0] * 26
            for j in range(i, n):
                freq[ord(s[j]) - ord('a')] += 1
                count = sum(1 for f in freq if f > 0)
                total += max(freq) - min(f for f in freq if f > 0)

        return total