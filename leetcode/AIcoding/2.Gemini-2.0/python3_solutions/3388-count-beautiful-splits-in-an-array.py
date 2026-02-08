class Solution:
    def countBeautifulPairs(self, nums: List[int]) -> int:
        def count_distinct_prime_factors(n):
            count = 0
            i = 2
            while i * i <= n:
                if n % i == 0:
                    count += 1
                    while n % i == 0:
                        n //= i
                i += 1
            if n > 1:
                count += 1
            return count

        n = len(nums)
        ans = 0
        for i in range(n):
            for j in range(i + 1, n):
                if count_distinct_prime_factors(nums[i]) == count_distinct_prime_factors(nums[j]):
                    ans += 1
        return ans