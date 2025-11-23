class Solution:
    def maxScore(self, nums: List[int]) -> int:
        from collections import defaultdict

        def get_factors(n):
            factors = set()
            for i in range(1, int(n**0.5) + 1):
                if n % i == 0:
                    factors.add(i)
                    factors.add(n // i)
            return factors

        score = 0
        used = set()
        factors_count = defaultdict(int)

        for num in nums:
            factors = get_factors(num)
            for f in factors:
                factors_count[f] += 1

        for num in nums:
            factors = get_factors(num)
            for f in sorted(factors, reverse=True):
                if factors_count[f] > 0 and f not in used:
                    score += f
                    used.add(f)
                    factors_count[f] -= 1
                    break

        return score