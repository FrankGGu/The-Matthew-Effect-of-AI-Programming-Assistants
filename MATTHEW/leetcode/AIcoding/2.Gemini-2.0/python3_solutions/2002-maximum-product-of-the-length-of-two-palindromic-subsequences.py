class Solution:
    def maxProduct(self, s: str) -> int:
        n = len(s)
        palindromes = {}

        def is_palindrome(subsequence):
            return subsequence == subsequence[::-1]

        def find_palindromes(index, current_subsequence):
            if index == n:
                if current_subsequence:
                    if is_palindrome(current_subsequence):
                        palindromes[current_subsequence] = len(current_subsequence)
                return

            find_palindromes(index + 1, current_subsequence)
            find_palindromes(index + 1, current_subsequence + s[index])

        find_palindromes(0, "")

        max_product = 0
        palindrome_list = list(palindromes.keys())

        for i in range(len(palindrome_list)):
            for j in range(i, len(palindrome_list)):
                p1 = palindrome_list[i]
                p2 = palindrome_list[j]

                if not any(c in p1 for c in p2):
                    max_product = max(max_product, len(p1) * len(p2))

        return max_product