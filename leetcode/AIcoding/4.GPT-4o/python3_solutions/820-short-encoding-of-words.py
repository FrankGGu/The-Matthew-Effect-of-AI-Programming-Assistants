class Solution:
    def minimumLengthEncoding(self, words: List[str]) -> int:
        suffix_set = set(word for word in words)
        for word in words:
            for i in range(1, len(word)):
                suffix_set.discard(word[i:])
        return sum(len(word) + 1 for word in suffix_set)