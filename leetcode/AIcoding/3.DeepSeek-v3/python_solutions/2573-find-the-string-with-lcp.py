class Solution:
    def findTheString(self, lcp: List[List[int]]) -> str:
        n = len(lcp)
        s = [''] * n
        current_char = 'a'

        for i in range(n):
            if s[i] == '':
                if current_char > 'z':
                    return ""
                s[i] = current_char
                for j in range(i + 1, n):
                    if lcp[i][j] > 0:
                        if j >= n or (i + 1 < n and j + 1 < n and lcp[i + 1][j + 1] != lcp[i][j] - 1):
                            return ""
                        s[j] = s[i]
                current_char = chr(ord(current_char) + 1)

        for i in range(n):
            for j in range(n):
                if i == j:
                    if lcp[i][j] != n - i:
                        return ""
                else:
                    if s[i] == s[j]:
                        if i + 1 < n and j + 1 < n:
                            if lcp[i][j] != lcp[i + 1][j + 1] + 1:
                                return ""
                        else:
                            if lcp[i][j] != 1:
                                return ""
                    else:
                        if lcp[i][j] != 0:
                            return ""

        return ''.join(s)