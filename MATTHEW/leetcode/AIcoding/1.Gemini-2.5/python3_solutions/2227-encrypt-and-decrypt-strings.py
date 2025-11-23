import collections

class Encrypter:

    def __init__(self, keys: list[str], values: list[str], dictionary: list[str]):
        self.key_to_value_map = {k: v for k, v in zip(keys, values)}
        self.encrypted_word_counts = collections.Counter()

        for word in dictionary:
            encrypted_word = self.encrypt(word)
            self.encrypted_word_counts[encrypted_word] += 1

    def encrypt(self, word1: str) -> str:
        encrypted_parts = []
        for char_code in word1:
            if char_code in self.key_to_value_map:
                encrypted_parts.append(self.key_to_value_map[char_code])
            else:
                # According to problem constraints, word1 will only contain characters in keys.
                # If not, this would be an error or require specific handling (e.g., return empty string or raise error).
                # For LeetCode, assume valid input based on constraints.
                pass 
        return "".join(encrypted_parts)

    def decrypt(self, word2: str) -> int:
        return self.encrypted_word_counts[word2]