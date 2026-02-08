class Solution:
    def replaceDigits(self, s: str) -> str:
        result = []
        for i in range(len(s)):
            if s[i].isdigit():
                result.append(chr(ord(s[i - 1]) + int(s[i])))
            else:
                result.append(s[i])
        return ''.join(result)