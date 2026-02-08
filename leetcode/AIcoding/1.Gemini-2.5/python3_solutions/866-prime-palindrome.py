import math

class Solution:
    def is_prime(self, num: int) -> bool:
        if num < 2:
            return False
        if num == 2:
            return True
        if num % 2 == 0:
            return False

        limit = int(math.sqrt(num))
        for i in range(3, limit + 1, 2):
            if num % i == 0:
                return False
        return True

    def primePalindrome(self, n: int) -> int:
        if n <= 2: return 2
        if n <= 3: return 3
        if n <= 5: return 5
        if n <= 7: return 7
        if n <= 11: return 11

        for x in range(1, 20000):
            s = str(x)
            p_str = s + s[:-1][::-1]
            p = int(p_str)

            if p < n:
                continue

            if self.is_prime(p):
                return p

        return -1