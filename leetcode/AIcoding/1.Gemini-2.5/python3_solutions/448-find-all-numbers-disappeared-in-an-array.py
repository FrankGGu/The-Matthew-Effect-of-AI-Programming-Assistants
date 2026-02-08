from typing import List

class Solution:
    def findDisappearedNumbers(self, nums: List[int]) -> List[int]:
        n = len(nums)

        for i in range(n):
            num_val = abs(nums[i])
            index_to_mark = num_val - 1
            if nums[index_to_mark] > 0:
                nums[index_to_mark] = -nums[index_to_mark]

        result = []
        for i in range(n):
            if nums[i] > 0:
                result.append(i + 1)

        return result