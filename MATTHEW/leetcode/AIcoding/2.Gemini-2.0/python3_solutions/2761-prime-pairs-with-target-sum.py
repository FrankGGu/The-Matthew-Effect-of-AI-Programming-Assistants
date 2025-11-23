def is_prime(n):
    if n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

class Solution:
    def findPrimePairs(self, n: int) -> list[list[int]]:
        result = []
        for i in range(2, n // 2 + 1):
            if is_prime(i) and is_prime(n - i):
                result.append([i, n - i])
        return result