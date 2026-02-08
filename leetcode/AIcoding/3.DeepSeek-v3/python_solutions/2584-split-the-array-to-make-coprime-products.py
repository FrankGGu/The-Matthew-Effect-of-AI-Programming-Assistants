import math

class Solution:
    def findValidSplit(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return -1

        left_primes = set()
        right_primes = defaultdict(int)

        def get_primes(x):
            primes = set()
            if x == 1:
                return primes
            for i in range(2, int(math.sqrt(x)) + 1):
                while x % i == 0:
                    primes.add(i)
                    x = x // i
            if x > 1:
                primes.add(x)
            return primes

        for num in nums:
            primes = get_primes(num)
            for p in primes:
                right_primes[p] += 1

        common = 0
        for i in range(n - 1):
            num = nums[i]
            primes = get_primes(num)
            for p in primes:
                if p not in left_primes:
                    common += 1
                    left_primes.add(p)
                right_primes[p] -= 1
                if right_primes[p] == 0:
                    common -= 1
            if common == 0:
                return i
        return -1