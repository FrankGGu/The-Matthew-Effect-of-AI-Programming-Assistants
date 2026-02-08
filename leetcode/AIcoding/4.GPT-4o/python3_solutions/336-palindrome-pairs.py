class Solution:
    def palindromePairs(self, words):
        def is_palindrome(word):
            return word == word[::-1]

        word_index = {word: i for i, word in enumerate(words)}
        result = []

        for i, word in enumerate(words):
            for j in range(len(word) + 1):
                left, right = word[:j], word[j:]

                if is_palindrome(left):
                    back = right[::-1]
                    if back in word_index and word_index[back] != i:
                        result.append([word_index[back], i])

                if j != len(word) and is_palindrome(right):
                    back = left[::-1]
                    if back in word_index and word_index[back] != i:
                        result.append([i, word_index[back]])

        return result