class Solution:
    def maxProduct(self, words: List[str]) -> int:
        def is_palindrome(s):
            return s == s[::-1]

        n = len(words)
        palindromes = [is_palindrome(word) for word in words]
        max_product = 0

        for i in range(n):
            for j in range(i + 1, n):
                if palindromes[i] and palindromes[j]:
                    max_product = max(max_product, len(words[i]) * len(words[j]))

        return max_product