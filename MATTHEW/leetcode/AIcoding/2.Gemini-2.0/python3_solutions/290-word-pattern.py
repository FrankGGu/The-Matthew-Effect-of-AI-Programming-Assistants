class Solution:
    def wordPattern(self, pattern: str, s: str) -> bool:
        words = s.split()
        if len(pattern) != len(words):
            return False

        pattern_to_word = {}
        word_to_pattern = {}

        for p, w in zip(pattern, words):
            if p not in pattern_to_word and w not in word_to_pattern:
                pattern_to_word[p] = w
                word_to_pattern[w] = p
            elif p in pattern_to_word and w in word_to_pattern:
                if pattern_to_word[p] != w or word_to_pattern[w] != p:
                    return False
            else:
                return False

        return True