class Solution:
    def minimumLength(self, s: str) -> int:
        while len(s) > 0 and s[0] == s[-1]:
            first_char = s[0]
            while s and s[0] == first_char:
                s = s[1:]
            while s and s[-1] == first_char:
                s = s[:-1]
        return len(s)