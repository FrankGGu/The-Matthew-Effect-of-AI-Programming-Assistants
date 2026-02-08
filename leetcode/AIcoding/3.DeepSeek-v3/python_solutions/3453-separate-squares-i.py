class Solution:
    def separateSquares(self, nums: List[int]) -> List[int]:
        left, right = 0, len(nums) - 1
        result = [0] * len(nums)
        index = right

        while left <= right:
            left_sq = nums[left] ** 2
            right_sq = nums[right] ** 2
            if left_sq > right_sq:
                result[index] = left_sq
                left += 1
            else:
                result[index] = right_sq
                right -= 1
            index -= 1

        return result