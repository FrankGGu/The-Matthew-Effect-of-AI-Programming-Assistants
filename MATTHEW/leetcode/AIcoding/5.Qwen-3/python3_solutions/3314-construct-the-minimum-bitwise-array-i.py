from typing import List

class Solution:
    def minBitwiseArray(self, nums: List[int]) -> List[int]:
        def get_min_bitwise(num):
            for i in range(1, num):
                if (i | num) == num:
                    return i
            return num

        result = []
        for num in nums:
            result.append(get_min_bitwise(num))
        return result