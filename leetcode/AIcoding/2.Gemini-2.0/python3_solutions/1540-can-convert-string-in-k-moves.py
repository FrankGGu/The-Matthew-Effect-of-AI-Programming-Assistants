class Solution:
    def canConvertString(self, s: str, t: str, k: int) -> bool:
        if len(s) != len(t):
            return False

        diffs = {}
        for i in range(len(s)):
            diff = (ord(t[i]) - ord(s[i])) % 26
            if diff > 0:
                if diff not in diffs:
                    diffs[diff] = 0
                diffs[diff] += 1

        for diff in diffs:
            if diff + (diffs[diff] - 1) * 26 > k:
                return False

        return True