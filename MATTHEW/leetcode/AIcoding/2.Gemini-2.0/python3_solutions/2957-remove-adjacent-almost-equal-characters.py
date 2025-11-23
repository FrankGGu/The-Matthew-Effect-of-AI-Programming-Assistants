class Solution:
    def removeAlmostEqualCharacters(self, s: str) -> int:
        count = 0
        i = 0
        while i < len(s) - 1:
            if abs(ord(s[i]) - ord(s[i + 1])) <= 1:
                count += 1
                i += 2
            else:
                i += 1
        return count