class Solution:
    def canConvertString(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        from collections import defaultdict

        count = defaultdict(int)
        for sc, tc in zip(s, t):
            diff = (ord(tc) - ord(sc)) % 26
            if diff == 0:
                continue
            if count[diff] >= 25:
                return False
            count[diff] += 1

        return True