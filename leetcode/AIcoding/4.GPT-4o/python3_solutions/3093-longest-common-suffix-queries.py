class SuffixArray:
    def __init__(self, words):
        self.words = words
        self.suffixes = []
        for word in words:
            for i in range(len(word)):
                self.suffixes.append((word[i:], i))

        self.suffixes.sort()

    def longest_common_suffix(self, query):
        lcs = ""
        for suffix, index in self.suffixes:
            if suffix.startswith(query):
                common_suffix = suffix[len(query):]
                if len(common_suffix) > len(lcs):
                    lcs = common_suffix
        return lcs

class Solution:
    def longestCommonSuffix(self, words: List[str], queries: List[str]) -> List[str]:
        suffix_array = SuffixArray(words)
        return [suffix_array.longest_common_suffix(query) for query in queries]