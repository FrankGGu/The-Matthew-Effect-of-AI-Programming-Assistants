class Solution:
    def sortString(self, s: str) -> str:
        from collections import Counter

        count = Counter(s)
        sorted_chars = sorted(count.keys())
        result = []

        while len(result) < len(s):
            for c in sorted_chars:
                if count[c] > 0:
                    result.append(c)
                    count[c] -= 1
            for c in reversed(sorted_chars):
                if count[c] > 0:
                    result.append(c)
                    count[c] -= 1

        return ''.join(result)