class Solution:
    def wordPatternMatch(self, pattern: str, s: str) -> bool:
        char_to_word = {}
        word_to_char = {}

        def backtrack(p_idx, s_idx):
            if p_idx == len(pattern) and s_idx == len(s):
                return True
            if p_idx == len(pattern) or s_idx == len(s):
                return False

            char = pattern[p_idx]

            if char in char_to_word:
                word = char_to_word[char]
                if s_idx + len(word) <= len(s) and s[s_idx : s_idx + len(word)] == word:
                    if backtrack(p_idx + 1, s_idx + len(word)):
                        return True
                return False
            else:
                for end_idx in range(s_idx + 1, len(s) + 1):
                    word = s[s_idx : end_idx]

                    if word not in word_to_char:
                        char_to_word[char] = word
                        word_to_char[word] = char

                        if backtrack(p_idx + 1, end_idx):
                            return True

                        del char_to_word[char]
                        del word_to_char[word]

                return False

        return backtrack(0, 0)