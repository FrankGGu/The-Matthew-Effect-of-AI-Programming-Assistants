class Solution:
    def lexSmallestString(self, s: str) -> str:
        s = list(s)
        n = len(s)
        for i in range(n):
            if s[i] != '0':
                break
        else:
            return '0' * n
        for i in range(n):
            if s[i] == '0':
                continue
            for j in range(i + 1, n):
                if s[j] == '0':
                    break
                if s[j] < s[i]:
                    s[i], s[j] = s[j], s[i]
                    return ''.join(s)
        return ''.join(s)