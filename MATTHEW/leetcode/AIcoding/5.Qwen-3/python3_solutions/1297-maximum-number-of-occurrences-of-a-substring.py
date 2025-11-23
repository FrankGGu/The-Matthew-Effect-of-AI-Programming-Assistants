class Solution:
    def maxFreq(self, s: str, maxLetters: int, minSize: int, maxSize: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        n = len(s)
        for i in range(n - minSize + 1):
            substr = s[i:i+minSize]
            if len(set(substr)) <= maxLetters:
                count[substr] += 1
        return max(count.values()) if count else 0