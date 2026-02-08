class Solution:
    def canMakeSubsequence(self, str1: str, str2: str) -> bool:
        m, n = len(str1), len(str2)
        if n > m:
            return False
        i = j = 0
        while i < m and j < n:
            c1 = str1[i]
            c2 = str2[j]
            if c1 == c2 or chr((ord(c1) - ord('a') + 1) % 26 + ord('a')) == c2:
                j += 1
            i += 1
        return j == n