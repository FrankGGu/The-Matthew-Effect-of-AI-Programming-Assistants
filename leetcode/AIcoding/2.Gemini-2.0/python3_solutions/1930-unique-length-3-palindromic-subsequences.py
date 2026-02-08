class Solution:
    def countPalindromicSubsequence(self, s: str) -> int:
        first = {}
        last = {}
        for i, c in enumerate(s):
            if c not in first:
                first[c] = i
            last[c] = i

        count = 0
        for c in set(s):
            for d in set(s):
                l = first[c]
                r = last[c]
                if l < r:
                    sub = s[l+1:r]
                    if d in sub:
                        count += 1

        return count