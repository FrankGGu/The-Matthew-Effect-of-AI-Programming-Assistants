class Solution:
    def primeSubOperation(self, nums: List[int]) -> bool:
        def get_primes_up_to(n):
            sieve = [True] * (n + 1)
            sieve[0] = sieve[1] = False
            for i in range(2, int(n ** 0.5) + 1):
                if sieve[i]:
                    sieve[i*i :: i] = [False] * len(sieve[i*i :: i])
            primes = [i for i, is_prime in enumerate(sieve) if is_prime]
            return primes

        max_num = max(nums)
        primes = get_primes_up_to(max_num)

        prev = 0
        for num in nums:
            if num <= prev:
                return False
            left = 0
            right = len(primes) - 1
            best_p = 0
            while left <= right:
                mid = (left + right) // 2
                if primes[mid] < num - prev:
                    best_p = primes[mid]
                    left = mid + 1
                else:
                    right = mid - 1
            num -= best_p
            prev = num
        return True