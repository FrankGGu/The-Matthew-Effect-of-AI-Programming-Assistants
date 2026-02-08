class Solution:
    def maxScoreIndices(self, nums: list[int]) -> list[int]:
        n = len(nums)

        right_ones = sum(nums)

        left_zeros = 0
        max_score = -1
        result_indices = []

        for i in range(n + 1):
            current_score = left_zeros + right_ones

            if current_score > max_score:
                max_score = current_score
                result_indices = [i]
            elif current_score == max_score:
                result_indices.append(i)

            if i < n:
                if nums[i] == 0:
                    left_zeros += 1
                else:
                    right_ones -= 1

        return result_indices