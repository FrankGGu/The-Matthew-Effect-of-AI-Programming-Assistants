class Solution:
    def sumOfGoodNumbers(self, n: int) -> int:
        mod = 10**9 + 7
        half = n // 2
        even_count = pow(5, half, mod)
        odd_count = pow(5, half + (n % 2), mod)
        return (even_count * odd_count) % mod