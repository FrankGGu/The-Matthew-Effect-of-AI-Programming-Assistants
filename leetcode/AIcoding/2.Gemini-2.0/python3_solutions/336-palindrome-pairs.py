class Solution:
    def palindromePairs(self, words: List[str]) -> List[List[int]]:
        word_dict = {word: i for i, word in enumerate(words)}
        result = []
        for i, word in enumerate(words):
            n = len(word)
            for j in range(n + 1):
                prefix = word[:j]
                suffix = word[j:]
                if prefix[::-1] in word_dict and word_dict[prefix[::-1]] != i and suffix == suffix[::-1]:
                    result.append([i, word_dict[prefix[::-1]]])
                if j > 0 and suffix[::-1] in word_dict and word_dict[suffix[::-1]] != i and prefix == prefix[::-1]:
                    result.append([word_dict[suffix[::-1]], i])
        return result