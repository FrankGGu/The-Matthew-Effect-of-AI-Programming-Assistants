class Solution:
    def decodeMessage(self, key: str, message: str) -> str:
        mapping = {}
        current_char = 'a'
        for char in key:
            if char != ' ' and char not in mapping:
                mapping[char] = current_char
                current_char = chr(ord(current_char) + 1)

        decoded_message = ""
        for char in message:
            if char == ' ':
                decoded_message += ' '
            else:
                decoded_message += mapping[char]

        return decoded_message