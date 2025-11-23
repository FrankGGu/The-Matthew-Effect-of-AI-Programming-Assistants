class Solution:
    def findPrimePairs(self, n: int) -> list[int]:
        if n < 4:
            return [-1, -1]

        is_prime = [True] * (n + 1)
        is_prime[0] = is_prime[1] = False

        for p in range(2, int(n**0.5) + 1):
            if is_prime[p]:
                for multiple in range(p * p, n + 1, p):
                    is_prime[multiple] = False

        for num1 in range(2, n // 2 + 1):
            if is_prime[num1]:
                num2 = n - num1
                if is_prime[num2]:
                    return [num1, num2]

        return [-1, -1]