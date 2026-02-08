class Solution:
    def primeSubOperation(self, nums: list[int]) -> bool:
        primes = []
        is_prime = [True] * 1001
        is_prime[0] = is_prime[1] = False
        for i in range(2, int(1000**0.5) + 1):
            if is_prime[i]:
                for j in range(i*i, 1001, i):
                    is_prime[j] = False
        for i in range(2, 1001):
            if is_prime[i]:
                primes.append(i)

        n = len(nums)
        prev = 0
        for i in range(n):
            if nums[i] <= prev:
                return False
            for p in reversed(primes):
                if nums[i] - p > prev and nums[i] - p > 0:
                    nums[i] -= p
                    break
            if nums[i] <= prev:
                return False
            prev = nums[i]
        return True