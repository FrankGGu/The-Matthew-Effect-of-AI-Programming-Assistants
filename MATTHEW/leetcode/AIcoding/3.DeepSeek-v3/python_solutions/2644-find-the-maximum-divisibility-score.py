class Solution:
    def maxDivScore(self, nums: List[int], divisors: List[int]) -> int:
        max_score = -1
        result_divisor = float('inf')

        for d in sorted(divisors):
            score = 0
            for num in nums:
                if num % d == 0:
                    score += 1
            if score > max_score:
                max_score = score
                result_divisor = d
            elif score == max_score and d < result_divisor:
                result_divisor = d

        return result_divisor