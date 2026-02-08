from typing import List

class Solution:
    def maxScoreIndices(self, nums: List[int]) -> List[int]:
        n = len(nums)
        ones_right = sum(nums)
        zeros_left = 0
        max_score = ones_right + zeros_left
        max_indices = [0]
        for i in range(n):
            if nums[i] == 0:
                zeros_left += 1
            else:
                ones_right -= 1
            score = zeros_left + ones_right
            if score > max_score:
                max_score = score
                max_indices = [i + 1]
            elif score == max_score:
                max_indices.append(i + 1)
        return max_indices