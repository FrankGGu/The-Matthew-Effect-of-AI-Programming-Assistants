class Solution:
    def shortestPalindrome(self, s: str) -> str:
        if not s:
            return s

        rev_s = s[::-1]
        l = s + "#" + rev_s
        n = len(l)

        lps = [0] * n
        j = 0

        for i in range(1, n):
            while j > 0 and l[i] != l[j]:
                j = lps[j - 1]
            if l[i] == l[j]:
                j += 1
            lps[i] = j

        return rev_s[:len(s) - lps[-1]] + s