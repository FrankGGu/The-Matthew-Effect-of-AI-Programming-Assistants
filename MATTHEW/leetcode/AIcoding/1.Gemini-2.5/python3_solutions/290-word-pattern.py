class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        words = s.split(' ')

        if len(pattern) != len(words):
            return False

        char_to_word = {}
        word_to_char = {}

        for i in range(len(pattern)):
            char = pattern[i]
            word = words[i]

            if char in char_to_word:
                if char_to_word[char] != word:
                    return False
            else:
                if word in word_to_char:
                    return False
                else:
                    char_to_word[char] = word
                    word_to_char[word] = char

        return True