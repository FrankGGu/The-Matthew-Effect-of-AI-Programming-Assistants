class Solution:
    def countHomogenous(self, s: str) -> int:
        count = 0
        i = 0
        n = len(s)
        while i < n:
            j = i
            while j < n and s[j] == s[i]:
                j += 1
            length = j - i
            count += length * (length + 1) // 2
            i = j
        return count