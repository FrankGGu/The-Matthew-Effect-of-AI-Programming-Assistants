class Solution:
    def primeSubtractionOperation(self, nums: List[int]) -> bool:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        primes = [i for i in range(2, 1001) if is_prime(i)]
        nums_sorted = sorted(nums)
        prev = 0
        for num in nums_sorted:
            found = False
            for p in primes:
                if p > num:
                    break
                if num - p > prev:
                    prev = num - p
                    found = True
                    break
            if not found:
                return False
        return True