class Solution:
    def makeFancyString(self, s: str) -> str:
        res = ""
        count = 0
        for i in range(len(s)):
            if len(res) == 0 or s[i] != res[-1]:
                res += s[i]
                count = 1
            elif s[i] == res[-1]:
                count += 1
                if count <= 2:
                    res += s[i]
        return res