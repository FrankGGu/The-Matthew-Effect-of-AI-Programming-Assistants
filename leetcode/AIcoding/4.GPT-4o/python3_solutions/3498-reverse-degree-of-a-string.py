class Solution:
    def reverseDegree(self, s: str) -> str:
        from collections import Counter
        count = Counter(s)
        return ''.join(sorted(s, key=lambda x: (-count[x], x)))