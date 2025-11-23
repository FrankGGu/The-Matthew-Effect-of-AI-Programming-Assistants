class Solution:
    def removeAlmostEqualCharacters(self, s: str) -> str:
        result = []
        i = 0
        while i < len(s):
            if not result or abs(ord(s[i]) - ord(result[-1])) > 1:
                result.append(s[i])
                i += 1
            else:
                i += 1
        return ''.join(result)