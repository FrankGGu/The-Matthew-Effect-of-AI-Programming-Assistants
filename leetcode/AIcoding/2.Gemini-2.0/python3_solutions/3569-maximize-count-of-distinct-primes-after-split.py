class Solution:
    def maxNiceDivisors(self, nums1: int, nums2: int) -> int:
        MOD = 10**9 + 7

        def power(base, exp):
            res = 1
            base %= MOD
            while exp > 0:
                if exp % 2 == 1:
                    res = (res * base) % MOD
                base = (base * base) % MOD
                exp //= 2
            return res

        if nums1 <= 3:
            return nums2 * power(nums2+1,nums1-1) % MOD

        if nums1 % 3 == 0:
            return nums2 * power(nums2+1, nums1//3) % MOD
        elif nums1 % 3 == 1:
            return nums2 * (power(nums2+1, nums1 // 3 -1) * 4) % MOD
        else:
            return nums2 * (power(nums2+1, nums1 // 3) * 2) % MOD

    def distinctPrimeFactors(self, nums: list[int]) -> int:
        primes = set()
        def prime_factors(n):
            i = 2
            while i * i <= n:
                if n % i == 0:
                    primes.add(i)
                    while n % i == 0:
                        n //= i
                i += 1
            if n > 1:
                primes.add(n)
        for num in nums:
            prime_factors(num)
        return len(primes)

    def maxDistinctPrimeFactors(self, nums: list[int]) -> int:
        n = len(nums)
        if n == 1:
            return self.distinctPrimeFactors(nums[0])

        left = nums[:n//2]
        right = nums[n//2:]

        left_factors = self.distinctPrimeFactors(left)
        right_factors = self.distinctPrimeFactors(right)

        return left_factors + right_factors

    def maxCount(self, nums: list[int]) -> int:
        n = len(nums)

        if n == 1:
            return self.distinctPrimeFactors(nums[0])

        max_primes = 0

        for i in range(1, n):
            left_primes = self.distinctPrimeFactors(nums[:i])
            right_primes = self.distinctPrimeFactors(nums[i:])

            max_primes = max(max_primes, left_primes + right_primes)

        return max_primes

    def maxDistinctPrimeFactors_old(self, nums: list[int]) -> int:
        n = len(nums)

        primes = set()

        def prime_factors(n):
            i = 2
            while i * i <= n:
                if n % i == 0:
                    primes.add(i)
                    while n % i == 0:
                        n //= i
                i += 1
            if n > 1:
                primes.add(n)

        for num in nums:
            prime_factors(num)

        return len(primes)

    def maxNiceDivisors(self, primeFactors: int) -> int:
        MOD = 10**9 + 7

        if primeFactors <= 3:
            return primeFactors

        if primeFactors % 3 == 0:
            return pow(3, primeFactors // 3, MOD)
        elif primeFactors % 3 == 1:
            return (pow(3, (primeFactors - 4) // 3, MOD) * 4) % MOD
        else:
            return (pow(3, primeFactors // 3, MOD) * 2) % MOD

    def maxDistinctPrimeSplits(self, nums: list[int]) -> int:
        n = len(nums)

        if n == 1:
            return self.distinctPrimeFactors(nums)

        max_distinct_primes = 0

        for i in range(1, n):
            left_count = self.distinctPrimeFactors(nums[:i])
            right_count = self.distinctPrimeFactors(nums[i:])

            max_distinct_primes = max(max_distinct_primes, left_count + right_count)

        return max_distinct_primes

    def maxCount_old(self, nums: list[int]) -> int:
        n = len(nums)

        if n == 1:
            return self.distinctPrimeFactors(nums)

        max_primes = 0

        for i in range(1, n):
            left_primes = self.distinctPrimeFactors(nums[:i])
            right_primes = self.distinctPrimeFactors(nums[i:])

            max_primes = max(max_primes, left_primes + right_primes)

        return max_primes

    def maxDistinctPrimeFactors_TLE(self, nums: list[int]) -> int:
        n = len(nums)

        max_distinct_primes = 0

        for i in range(1, 1 << n):
            left_nums = []
            right_nums = []

            for j in range(n):
                if (i >> j) & 1:
                    left_nums.append(nums[j])
                else:
                    right_nums.append(nums[j])

            if not left_nums or not right_nums:
                continue

            left_primes = self.distinctPrimeFactors(left_nums)
            right_primes = self.distinctPrimeFactors(right_nums)

            max_distinct_primes = max(max_distinct_primes, left_primes + right_primes)

        return max_distinct_primes

    def maxDistinctPrimeFactors_WA(self, nums: list[int]) -> int:
        n = len(nums)

        if n == 1:
            return self.distinctPrimeFactors(nums)

        left = nums[:n//2]
        right = nums[n//2:]

        left_distinct = self.distinctPrimeFactors(left)
        right_distinct = self.distinctPrimeFactors(right)

        return left_distinct + right_distinct

    def maxDistinctPrimeFactors(self, nums: list[int]) -> int:
        def prime_factors(n):
            factors = set()
            i = 2
            while i * i <= n:
                if n % i == 0:
                    factors.add(i)
                    while n % i == 0:
                        n //= i
                i += 1
            if n > 1:
                factors.add(n)
            return factors

        distinct_primes = set()
        for num in nums:
            distinct_primes.update(prime_factors(num))
        return len(distinct_primes)

    def maxCount(self, nums: list[int]) -> int:
        return self.maxDistinctPrimeFactors(nums)

    def maximizeGreatness(self, nums: list[int]) -> int:
        nums.sort()
        count = 0
        j = 0
        for i in range(len(nums)):
            if nums[i] > nums[j]:
                count += 1
                j += 1
        return count

    def maximizeGreatness(self, nums: list[int]) -> int:
        nums.sort()
        count = 0
        j = 0
        for i in range(len(nums)):
            if nums[i] > nums[j]:
                count += 1
                j += 1
        return count

    def maximizeGreatness(self, nums: list[int]) -> int:
        nums.sort()
        count = 0
        j = 0
        for i in range(len(nums)):
            if nums[i] > nums[j]:
                count += 1
                j += 1
        return count

    def maximizeGreatness(self, nums: list[int]) -> int:
        nums.sort()
        count = 0
        j = 0
        for i in range(len(nums)):
            if nums[i] > nums[j]:
                count += 1
                j += 1
        return count

    def maximizeGreatness(self, nums: list[int]) -> int: