import collections

class Solution:
    def splitArray(self, nums: list[int]) -> int:
        MAX_VAL = 10**6
        spf = [0] * (MAX_VAL + 1) # Smallest Prime Factor

        for i in range(2, MAX_VAL + 1):
            if spf[i] == 0:
                spf[i] = i
                for multiple in range(i * i, MAX_VAL + 1, i):
                    if spf[multiple] == 0:
                        spf[multiple] = i

        def get_prime_factors(n: int) -> set[int]:
            factors = set()
            if n == 1:
                return factors

            temp_n = n
            while temp_n > 1:
                factors.add(spf[temp_n])
                temp_n //= spf[temp_n]
            return factors

        n = len(nums)

        left_prime_freq = collections.defaultdict(int)
        right_prime_freq = collections.defaultdict(int)

        for num in nums:
            for p in get_prime_factors(num):
                right_prime_freq[p] += 1

        coprime_splits = 0
        shared_primes_count = 0

        for i in range(n - 1):
            num_to_move = nums[i]

            for p in get_prime_factors(num_to_move):
                was_shared = (left_prime_freq[p] > 0 and right_prime_freq[p] > 0)

                left_prime_freq[p] += 1
                right_prime_freq[p] -= 1

                is_shared = (left_prime_freq[p] > 0 and right_prime_freq[p] > 0)

                if was_shared and not is_shared:
                    shared_primes_count -= 1
                elif not was_shared and is_shared:
                    shared_primes_count += 1

            if shared_primes_count == 0:
                coprime_splits += 1

        return coprime_splits