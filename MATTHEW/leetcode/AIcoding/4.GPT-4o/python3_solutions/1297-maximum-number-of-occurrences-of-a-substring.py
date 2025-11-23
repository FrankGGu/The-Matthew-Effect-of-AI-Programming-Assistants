class Solution:
    def maxFreq(self, s: str, maxLetters: int, minSize: int, maxSize: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        n = len(s)

        for size in range(minSize, maxSize + 1):
            for i in range(n - size + 1):
                substring = s[i:i + size]
                if len(set(substring)) <= maxLetters:
                    count[substring] += 1

        return max(count.values(), default=0)