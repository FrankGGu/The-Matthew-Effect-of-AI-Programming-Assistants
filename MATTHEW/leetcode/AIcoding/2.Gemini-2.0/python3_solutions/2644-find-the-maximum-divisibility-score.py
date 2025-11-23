class Solution:
    def maxDivScore(self, nums: list[int], divisors: list[int]) -> int:
        max_score = -1
        result = -1

        for divisor in divisors:
            score = 0
            for num in nums:
                if num % divisor == 0:
                    score += 1

            if score > max_score:
                max_score = score
                result = divisor
            elif score == max_score:
                result = min(result, divisor)

        return result