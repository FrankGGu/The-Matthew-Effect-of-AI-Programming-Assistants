class Solution:
    def maxProduct(self, words: List[str]) -> int:
        def is_palindrome(word):
            return word == word[::-1]

        n = len(words)
        palindromic_words = [i for i in range(n) if is_palindrome(words[i])]
        max_product = 0

        for i in range(len(palindromic_words)):
            for j in range(i + 1, len(palindromic_words)):
                if not set(words[palindromic_words[i]]).intersection(set(words[palindromic_words[j]])):
                    max_product = max(max_product, len(words[palindromic_words[i]]) * len(words[palindromic_words[j]]))

        return max_product