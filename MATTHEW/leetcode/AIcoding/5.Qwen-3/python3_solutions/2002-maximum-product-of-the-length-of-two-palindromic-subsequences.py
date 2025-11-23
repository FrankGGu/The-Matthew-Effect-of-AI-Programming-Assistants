class Solution:
    def maxProduct(self, s: str) -> int:
        def is_palindrome(sub):
            return sub == sub[::-1]

        n = len(s)
        max_len = 0
        palindromes = []

        for mask in range(1, 1 << n):
            sub = []
            for i in range(n):
                if mask & (1 << i):
                    sub.append(s[i])
            sub_str = ''.join(sub)
            if is_palindrome(sub_str):
                palindromes.append((len(sub_str), sub_str))

        max_product = 0
        m = len(palindromes)
        for i in range(m):
            len1, sub1 = palindromes[i]
            for j in range(i + 1, m):
                len2, sub2 = palindromes[j]
                if not set(sub1) & set(sub2):
                    max_product = max(max_product, len1 * len2)

        return max_product