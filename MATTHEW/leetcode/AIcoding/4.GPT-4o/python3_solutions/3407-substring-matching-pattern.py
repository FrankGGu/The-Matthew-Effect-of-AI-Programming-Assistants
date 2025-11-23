class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        words = s.split()
        if len(pattern) != len(words):
            return False

        char_to_word = {}
        word_to_char = {}

        for p, w in zip(pattern, words):
            if p not in char_to_word:
                char_to_word[p] = w
            if w not in word_to_char:
                word_to_char[w] = p

            if char_to_word[p] != w or word_to_char[w] != p:
                return False

        return True