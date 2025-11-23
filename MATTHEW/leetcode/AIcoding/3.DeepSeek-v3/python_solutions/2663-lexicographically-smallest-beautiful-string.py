class Solution:
    def smallestBeautifulString(self, s: str, k: int) -> str:
        n = len(s)
        s = list(s)
        i = n - 1
        while i >= 0:
            s[i] = chr(ord(s[i]) + 1)
            if ord(s[i]) - ord('a') >= k:
                s[i] = 'a'
                i -= 1
            else:
                if (i >= 1 and s[i] == s[i-1]) or (i >= 2 and s[i] == s[i-2]):
                    continue
                for j in range(i + 1, n):
                    for c in ['a', 'b', 'c']:
                        if (j >= 1 and c == s[j-1]) or (j >= 2 and c == s[j-2]):
                            continue
                        s[j] = c
                        break
                return ''.join(s)
        return ""