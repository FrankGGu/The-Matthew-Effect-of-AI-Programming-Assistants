class Solution:
    def largestPalindrome(self, n: int, k: int) -> int:
        def is_palindrome(num):
            return str(num) == str(num)[::-1]

        max_num = 10**n - 1
        min_num = 10**(n - 1)

        for i in range(max_num, min_num - 1, -1):
            if is_palindrome(i):
                if i % k == 0:
                    return i
        return -1