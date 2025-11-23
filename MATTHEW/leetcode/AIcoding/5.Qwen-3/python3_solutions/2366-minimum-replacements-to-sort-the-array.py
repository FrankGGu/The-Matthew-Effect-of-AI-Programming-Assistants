class Solution:
    def primeSubOperation(self, nums: List[int]) -> int:
        def is_prime(n):
            if n < 2:
                return False
            for i in range(2, int(n**0.5) + 1):
                if n % i == 0:
                    return False
            return True

        max_num = max(nums)
        primes = [i for i in range(2, max_num) if is_prime(i)]

        res = 0
        prev = 0
        for num in nums:
            if num > prev:
                prev = num
                continue
            found = False
            for p in primes:
                if p >= num:
                    break
                if num - p > prev:
                    prev = num - p
                    res += 1
                    found = True
                    break
            if not found:
                prev = num - 1
                res += 1
        return res