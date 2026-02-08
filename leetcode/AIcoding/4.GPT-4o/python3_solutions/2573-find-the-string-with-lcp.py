class Solution:
    def findTheString(self, n: int, lcp: List[List[int]]) -> str:
        s = [''] * n
        for i in range(n):
            if s[i] == '':
                s[i] = 'a'
            for j in range(i + 1, n):
                if lcp[i][j] == 0:
                    if s[j] == '':
                        s[j] = 'b' if s[i] == 'a' else 'a'
                elif lcp[i][j] == 1:
                    if s[j] == '':
                        s[j] = s[i]
                elif lcp[i][j] == n:
                    s[j] = s[i]
        return ''.join(s)