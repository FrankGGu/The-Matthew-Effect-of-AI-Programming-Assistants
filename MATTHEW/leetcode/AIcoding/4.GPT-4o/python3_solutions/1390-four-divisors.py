class Solution:
    def sumFourDivisors(self, nums: List[int]) -> int:
        def four_divisors_sum(n):
            divisors = []
            for i in range(1, int(n**0.5) + 1):
                if n % i == 0:
                    divisors.append(i)
                    if i != n // i:
                        divisors.append(n // i)
                if len(divisors) > 4:
                    return 0
            return sum(divisors) if len(divisors) == 4 else 0

        return sum(four_divisors_sum(num) for num in nums)