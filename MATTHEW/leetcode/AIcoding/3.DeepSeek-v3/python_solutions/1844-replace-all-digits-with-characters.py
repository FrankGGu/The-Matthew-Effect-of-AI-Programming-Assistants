class Solution:
    def replaceDigits(self, s: str) -> str:
        result = []
        for i in range(len(s)):
            if i % 2 == 1:
                prev_char = s[i-1]
                shift = int(s[i])
                new_char = chr(ord(prev_char) + shift
                result.append(new_char)
            else:
                result.append(s[i])
        return ''.join(result)