class Solution:
    def findIndices(self, nums: list[int], indexDifference: int, valueDifference: int) -> list[int]:
        n = len(nums)

        min_val = nums[0]
        min_idx = 0
        max_val = nums[0]
        max_idx = 0

        for j in range(indexDifference, n):
            k = j - indexDifference

            if nums[k] < min_val:
                min_val = nums[k]
                min_idx = k
            if nums[k] > max_val:
                max_val = nums[k]
                max_idx = k

            if abs(min_val - nums[j]) >= valueDifference:
                return [min_idx, j]
            if abs(max_val - nums[j]) >= valueDifference:
                return [max_idx, j]

        return [-1, -1]