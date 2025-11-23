import math

class Solution:
    def largestPrimeInDiagonal(self, nums: list[list[int]]) -> int:
        def is_prime(n: int) -> bool:
            if n <= 1:
                return False
            if n <= 3:
                return True
            if n % 2 == 0 or n % 3 == 0:
                return False
            i = 5
            while i * i <= n:
                if n % i == 0 or n % (i + 2) == 0:
                    return False
                i += 6
            return True

        n = len(nums)
        max_prime = 0

        for i in range(n):
            # Main diagonal
            num1 = nums[i][i]
            if num1 > max_prime and is_prime(num1):
                max_prime = num1

            # Anti-diagonal
            num2 = nums[i][n - 1 - i]
            if num2 > max_prime and is_prime(num2):
                max_prime = num2

        return max_prime