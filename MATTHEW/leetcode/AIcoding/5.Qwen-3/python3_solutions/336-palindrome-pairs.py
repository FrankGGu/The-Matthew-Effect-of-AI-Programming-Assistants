class Solution:
    def palindromePairs(self, words: list[str]) -> list[list[int]]:
        word_to_index = {word: i for i, word in enumerate(words)}
        result = []

        for i, word in enumerate(words):
            for j in range(len(word)):
                left = word[:j]
                right = word[j:]
                if left[::-1] in word_to_index and word_to_index[left[::-1]] != i:
                    if right == right[::-1]:
                        result.append([i, word_to_index[left[::-1]]])
                if right[::-1] in word_to_index and word_to_index[right[::-1]] != i:
                    if left == left[::-1]:
                        result.append([word_to_index[right[::-1]], i])

        return result