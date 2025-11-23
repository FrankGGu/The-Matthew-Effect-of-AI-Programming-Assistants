class Solution:
    def maxScoreIndices(self, nums: List[int]) -> List[int]:
        left_zeros = 0
        right_ones = sum(nums)
        max_score = left_zeros + right_ones
        result = [0]

        for i in range(len(nums)):
            if nums[i] == 0:
                left_zeros += 1
            else:
                right_ones -= 1
            current_score = left_zeros + right_ones
            if current_score > max_score:
                max_score = current_score
                result = [i + 1]
            elif current_score == max_score:
                result.append(i + 1)

        return result