class Solution:
    def palindromePairs(self, words: List[str]) -> List[List[int]]:
        def is_palindrome(word):
            return word == word[::-1]

        word_index = {word: i for i, word in enumerate(words)}
        res = []

        for i, word in enumerate(words):
            n = len(word)
            for j in range(n + 1):
                prefix = word[:j]
                suffix = word[j:]

                if is_palindrome(prefix):
                    back = suffix[::-1]
                    if back != word and back in word_index:
                        res.append([word_index[back], i])

                if j != n and is_palindrome(suffix):
                    back = prefix[::-1]
                    if back != word and back in word_index:
                        res.append([i, word_index[back]])

        return res