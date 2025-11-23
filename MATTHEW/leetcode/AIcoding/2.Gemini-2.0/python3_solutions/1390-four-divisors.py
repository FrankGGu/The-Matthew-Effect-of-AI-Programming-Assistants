class Solution:
    def sumFourDivisors(self, nums: List[int]) -> int:
        def get_divisors_sum(n):
            divisors = []
            for i in range(1, int(n**0.5) + 1):
                if n % i == 0:
                    divisors.append(i)
                    if i * i != n:
                        divisors.append(n // i)
            if len(divisors) == 4:
                return sum(divisors)
            else:
                return 0

        total_sum = 0
        for num in nums:
            total_sum += get_divisors_sum(num)
        return total_sum