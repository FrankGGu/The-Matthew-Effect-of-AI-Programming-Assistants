from typing import List

class Solution:
    def countExpectedNumbers(self, nums: List[int], expected_values: List[int]) -> int:
        expected_set = set(expected_values)
        count = 0
        for num in nums:
            if num in expected_set:
                count += 1
        return count