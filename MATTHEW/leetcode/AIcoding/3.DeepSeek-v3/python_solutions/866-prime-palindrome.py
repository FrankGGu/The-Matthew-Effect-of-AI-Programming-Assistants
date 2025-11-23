class Solution:
    def primePalindrome(self, N: int) -> int:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n ** 0.5) + 1):
                if n % i == 0:
                    return False
            return True

        def next_palindrome(n):
            s = str(n)
            l = len(s)
            half = s[:(l + 1) // 2]
            if l % 2 == 0:
                candidate = int(half + half[::-1])
            else:
                candidate = int(half + half[:-1][::-1])
            if candidate >= n:
                return candidate
            half = str(int(half) + 1)
            if len(half) > (l + 1) // 2:
                if l % 2 == 0:
                    return int('1' + '0' * (l) + '1')
                else:
                    return int('1' + '0' * (l - 1) + '1')
            if l % 2 == 0:
                return int(half + half[::-1])
            else:
                return int(half + half[:-1][::-1])

        if N <= 2:
            return 2
        candidate = N
        while True:
            candidate = next_palindrome(candidate)
            if is_prime(candidate):
                return candidate