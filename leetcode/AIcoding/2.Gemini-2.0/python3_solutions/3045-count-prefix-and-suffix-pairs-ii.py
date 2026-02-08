class Solution:
    def countPrefixSuffixPairs(self, words: list[str]) -> int:
        def is_prefix_and_suffix(word1, word2):
            return word2.startswith(word1) and word2.endswith(word1)

        count = 0
        for i in range(len(words)):
            for j in range(i + 1, len(words)):
                if is_prefix_and_suffix(words[i], words[j]):
                    count += 1
        return count