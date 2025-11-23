class Solution:
    def maxFactorScore(self, nums: list[int]) -> int:
        max_score = -1
        result_num = -1

        for x in nums:
            current_score = 0
            for y in nums:
                if x % y == 0:
                    current_score += 1

            if current_score > max_score:
                max_score = current_score
                result_num = x
            elif current_score == max_score:
                result_num = min(result_num, x)

        return result_num