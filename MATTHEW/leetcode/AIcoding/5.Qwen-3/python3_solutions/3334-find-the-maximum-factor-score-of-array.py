class Solution:
    def maxFactorScore(self, nums: List[int]) -> int:
        from math import isqrt

        def factor_score(n):
            score = 1
            i = 2
            while i <= isqrt(n):
                count = 0
                while n % i == 0:
                    n //= i
                    count += 1
                if count > 0:
                    score *= (count + 1)
                i += 1
            if n > 1:
                score *= 2
            return score

        max_score = 0
        for num in nums:
            score = factor_score(num)
            if score > max_score:
                max_score = score
        return max_score