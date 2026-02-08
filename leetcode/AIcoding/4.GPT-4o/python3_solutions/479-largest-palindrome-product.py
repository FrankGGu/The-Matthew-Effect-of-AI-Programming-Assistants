class Solution:
    def largestPalindrome(self, n: int) -> int:
        if n == 1:
            return 9
        upper = 10 ** n - 1
        lower = 10 ** (n - 1)
        max_palindrome = 0

        for i in range(upper, lower - 1, -1):
            for j in range(i, lower - 1, -1):
                product = i * j
                if product <= max_palindrome:
                    break
                if str(product) == str(product)[::-1]:
                    max_palindrome = max(max_palindrome, product)

        return max_palindrome % 1337