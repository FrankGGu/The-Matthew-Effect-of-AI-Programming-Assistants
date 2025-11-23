class Solution:
    def isAlienSorted(self, words: list[str], order: str) -> bool:
        char_to_order = {char: i for i, char in enumerate(order)}

        def compare_words(word1: str, word2: str) -> bool:
            len1, len2 = len(word1), len(word2)
            min_len = min(len1, len2)

            for i in range(min_len):
                char1_val = char_to_order[word1[i]]
                char2_val = char_to_order[word2[i]]

                if char1_val < char2_val:
                    return True
                elif char1_val > char2_val:
                    return False

            return len1 <= len2

        for i in range(len(words) - 1):
            if not compare_words(words[i], words[i+1]):
                return False

        return True