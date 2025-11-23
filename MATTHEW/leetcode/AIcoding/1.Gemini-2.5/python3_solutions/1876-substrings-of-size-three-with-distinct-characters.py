class Solution:
    def countGoodSubstrings(self, s: str) -> int:
        count = 0
        n = len(s)
        if n < 3:
            return 0

        for i in range(n - 2):
            # Get the substring of length 3
            sub = s[i:i+3]

            # Check if all characters in the substring are distinct
            if sub[0] != sub[1] and sub[0] != sub[2] and sub[1] != sub[2]:
                count += 1

        return count