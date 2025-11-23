class Solution:
    def lexSmallestString(self, s: str) -> str:
        def dfs(s, i):
            if i >= len(s):
                return s
            res = s
            for j in range(i, len(s)):
                if j == i or s[j] != s[i]:
                    new_s = list(s)
                    new_s[j] = chr(ord(new_s[j]) - 1)
                    if new_s[j] < 'a':
                        new_s[j] = 'z'
                    new_s = ''.join(new_s)
                    temp = dfs(new_s, j + 1)
                    if temp < res:
                        res = temp
            return res
        return dfs(s, 0)