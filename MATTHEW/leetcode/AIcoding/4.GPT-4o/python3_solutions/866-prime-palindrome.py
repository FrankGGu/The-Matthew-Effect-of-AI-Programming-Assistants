class Solution:
    def primePalindrome(self, N: int) -> int:
        def is_prime(x):
            if x < 2:
                return False
            for i in range(2, int(x**0.5) + 1):
                if x % i == 0:
                    return False
            return True

        def is_palindrome(x):
            return str(x) == str(x)[::-1]

        for num in range(max(11, N), 10000000):
            if is_palindrome(num) and is_prime(num):
                return num