class Solution:
    def isSubstringPresent(self, s: str) -> bool:
        s_rev = s[::-1]
        n = len(s)

        for i in range(n - 1):
            sub = s[i:i+2]
            if sub in s_rev:
                return True

        return False