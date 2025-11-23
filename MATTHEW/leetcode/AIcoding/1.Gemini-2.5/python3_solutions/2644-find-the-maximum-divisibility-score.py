class Solution:
    def maxDivisibilityScore(self, nums: list[int], divisors: list[int]) -> int:
        max_score = -1
        result_divisor = -1

        for d in divisors:
            current_score = 0
            for n in nums:
                if n % d == 0:
                    current_score += 1

            if current_score > max_score:
                max_score = current_score
                result_divisor = d
            elif current_score == max_score:
                if d < result_divisor:
                    result_divisor = d

        return result_divisor