def decodeMessage(key: str, message: str) -> str:
    mapping = {}
    current_char = 'a'

    for char in key:
        if char != ' ' and char not in mapping:
            mapping[char] = current_char
            current_char = chr(ord(current_char) + 1)

    decoded_message = ''.join(mapping[char] if char in mapping else ' ' for char in message)
    return decoded_message