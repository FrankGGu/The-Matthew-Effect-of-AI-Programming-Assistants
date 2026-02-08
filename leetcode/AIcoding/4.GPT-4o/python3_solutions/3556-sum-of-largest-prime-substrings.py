class Solution:
    def largestPrimeSubstring(self, s: str) -> int:
        def is_prime(n):
            if n <= 1:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        max_prime = -1
        n = len(s)

        for i in range(n):
            for j in range(i + 1, n + 1):
                num_str = s[i:j]
                if num_str and num_str[0] != '0':
                    num = int(num_str)
                    if is_prime(num):
                        max_prime = max(max_prime, num)

        return max_prime if max_prime != -1 else 0