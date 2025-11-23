class Solution:
    def findAndReplacePattern(self, words, pattern):
        def get_pattern(word):
            mapping = {}
            return [mapping.setdefault(c, len(mapping)) for c in word]

        pattern_code = get_pattern(pattern)
        result = []
        for word in words:
            if get_pattern(word) == pattern_code:
                result.append(word)
        return result