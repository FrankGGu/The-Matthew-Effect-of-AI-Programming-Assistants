class Solution:
    def pathEncryption(self, s: str) -> str:
        result = []
        for char in s:
            if char == ' ':
                result.append(' ')
            else:
                result.append(chr(ord(char) + 1))
        return ''.join(result)