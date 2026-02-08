class Solution:
    def countSpecialSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        res = 0
        for i in range(n):
            for j in range(i + k, n + 1):
                substr = s[i:j]
                if len(substr) % k != 0:
                    continue
                valid = True
                for m in range(0, len(substr), k):
                    part = substr[m:m+k]
                    if len(set(part)) != 1:
                        valid = False
                        break
                    if m + k < len(substr) and part[0] == substr[m + k]:
                        valid = False
                        break
                if valid:
                    res += 1
        return res