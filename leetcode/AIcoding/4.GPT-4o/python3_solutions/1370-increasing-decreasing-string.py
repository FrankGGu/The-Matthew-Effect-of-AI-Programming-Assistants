class Solution:
    def sortString(self, s: str) -> str:
        from collections import Counter

        count = Counter(s)
        result = []

        while count:
            for c in sorted(count.keys()):
                result.append(c)
                count[c] -= 1
                if count[c] == 0:
                    del count[c]
            for c in sorted(count.keys(), reverse=True):
                result.append(c)
                count[c] -= 1
                if count[c] == 0:
                    del count[c]

        return ''.join(result)