class Solution:
    def decodeMessage(self, key: str, message: str) -> str:
        mapping = {}
        alphabet = 'abcdefghijklmnopqrstuvwxyz'
        index = 0
        for char in key:
            if char != ' ' and char not in mapping:
                mapping[char] = alphabet[index]
                index += 1
                if index == 26:
                    break
        decoded = []
        for char in message:
            if char == ' ':
                decoded.append(' ')
            else:
                decoded.append(mapping[char])
        return ''.join(decoded)