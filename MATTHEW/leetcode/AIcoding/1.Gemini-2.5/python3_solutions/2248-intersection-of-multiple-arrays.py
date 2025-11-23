from typing import List

class Solution:
    def intersection(self, nums: List[List[int]]) -> List[int]:
        result_set = set(nums[0])

        for i in range(1, len(nums)):
            result_set = result_set.intersection(set(nums[i]))

        result_list = list(result_set)
        result_list.sort()

        return result_list