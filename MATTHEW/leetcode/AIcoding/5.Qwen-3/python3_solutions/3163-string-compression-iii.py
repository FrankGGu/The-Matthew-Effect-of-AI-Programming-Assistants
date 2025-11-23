class Solution:
    def compressedString(self, s: str) -> str:
        if not s:
            return ""
        res = []
        n = len(s)
        i = 0
        while i < n:
            j = i
            while j < n and s[j] == s[i]:
                j += 1
            count = j - i
            res.append(str(count))
            res.append(s[i])
            i = j
        return ''.join(res)