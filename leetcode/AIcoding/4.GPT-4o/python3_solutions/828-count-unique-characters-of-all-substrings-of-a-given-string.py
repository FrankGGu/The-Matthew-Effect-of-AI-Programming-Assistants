class Solution:
    def uniqueLetterString(self, s: str) -> int:
        last = {}
        result = 0
        n = len(s)
        contribution = 0

        for i in range(n):
            if s[i] in last:
                contribution += (i - last[s[i]]) * (last[s[i]] - (last[s[i]] - 1 if s[last[s[i]] - 1] == s[i] else 0))
            else:
                contribution += (i + 1)
            last[s[i]] = i

            result += contribution

        return result