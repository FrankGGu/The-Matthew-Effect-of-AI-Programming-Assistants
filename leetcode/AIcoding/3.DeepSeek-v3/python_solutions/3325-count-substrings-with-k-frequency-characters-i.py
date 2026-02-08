class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        count = 0
        n = len(s)
        for i in range(n):
            freq = {}
            for j in range(i, n):
                char = s[j]
                freq[char] = freq.get(char, 0) + 1
                if any(v == k for v in freq.values()):
                    count += 1
        return count