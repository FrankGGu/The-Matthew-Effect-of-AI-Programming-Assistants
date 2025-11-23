class Solution:
    def largestPrimeSubstring(self, s: str) -> int:
        max_prime = 0
        n = len(s)
        for i in range(n):
            for j in range(i + 1, n + 1):
                num = int(s[i:j])
                if num > 1 and self.is_prime(num):
                    if num > max_prime:
                        max_prime = num
        return max_prime if max_prime != 0 else 0

    def is_prime(self, num: int) -> bool:
        if num < 2:
            return False
        for i in range(2, int(num ** 0.5) + 1):
            if num % i == 0:
                return False
        return True