class Solution:
    def countBalancedPermutations(self, n: int) -> int:
        def factorial(x):
            if x == 0 or x == 1:
                return 1
            result = 1
            for i in range(2, x + 1):
                result *= i
            return result

        if n % 2 != 0:
            return 0

        half_n = n // 2
        return factorial(n) // (factorial(half_n) ** 2)