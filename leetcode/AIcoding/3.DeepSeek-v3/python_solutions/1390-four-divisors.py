class Solution:
    def sumFourDivisors(self, nums: List[int]) -> int:
        def get_divisors(x):
            divisors = set()
            for i in range(1, int(x**0.5) + 1):
                if x % i == 0:
                    divisors.add(i)
                    divisors.add(x // i)
                    if len(divisors) > 4:
                        return None
            return sorted(divisors) if len(divisors) == 4 else None

        total = 0
        for num in nums:
            divisors = get_divisors(num)
            if divisors:
                total += sum(divisors)
        return total