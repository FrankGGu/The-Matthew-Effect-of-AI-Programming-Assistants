class Solution:
    def countSubstrings(self, s: str, c: str) -> int:
        count = 0
        n = len(s)

        for i in range(n):
            if s[i] == c:
                left = right = i
                while left >= 0 and right < n:
                    if s[left] == c or s[right] == c:
                        count += 1
                    left -= 1
                    right += 1

        return count