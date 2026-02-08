class Solution:
    def maxFreq(self, s: str, maxLetters: int, minSize: int, maxSize: int) -> int:
        from collections import defaultdict

        substr_count = defaultdict(int)
        n = len(s)

        for size in range(minSize, maxSize + 1):
            for i in range(n - size + 1):
                substr = s[i:i+size]
                if len(set(substr)) <= maxLetters:
                    substr_count[substr] += 1

        return max(substr_count.values()) if substr_count else 0