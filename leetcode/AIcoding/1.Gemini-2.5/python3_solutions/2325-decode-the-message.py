class Solution:
    def decodeMessage(self, key: str, message: str) -> str:
        mapping = {}
        current_char_code = ord('a')

        for char_in_key in key:
            if char_in_key != ' ' and char_in_key not in mapping:
                mapping[char_in_key] = chr(current_char_code)
                current_char_code += 1
                if current_char_code > ord('z'): # Optimization: stop if all 26 letters are mapped
                    break

        decoded_message_chars = []
        for char_in_message in message:
            if char_in_message == ' ':
                decoded_message_chars.append(' ')
            else:
                decoded_message_chars.append(mapping[char_in_message])

        return "".join(decoded_message_chars)