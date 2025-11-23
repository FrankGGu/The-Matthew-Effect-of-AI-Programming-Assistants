from typing import List

class Solution:
    def sumOfGoodNumbers(self, nums: List[int]) -> int:
        return sum(num for num in nums if num >= 0)