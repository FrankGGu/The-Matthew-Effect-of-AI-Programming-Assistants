class Solution:
    def diagonalPrime(self, nums: List[List[int]]) -> int:
        def is_prime(n):
            if n <= 1:
                return False
            if n == 2:
                return True
            if n % 2 == 0:
                return False
            for i in range(3, int(n**0.5) + 1, 2):
                if n % i == 0:
                    return False
            return True

        max_prime = 0
        n = len(nums)
        for i in range(n):
            num1 = nums[i][i]
            num2 = nums[i][n - 1 - i]
            if is_prime(num1) and num1 > max_prime:
                max_prime = num1
            if is_prime(num2) and num2 > max_prime:
                max_prime = num2
        return max_prime