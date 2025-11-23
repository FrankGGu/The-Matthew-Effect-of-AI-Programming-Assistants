from typing import List

class Solution:
    def minBitwiseArray(self, nums: List[int]) -> List[int]:
        def get_min_bitwise(num):
            for i in range(30, -1, -1):
                if num & (1 << i):
                    return num ^ (1 << i)
            return num

        result = []
        for num in nums:
            result.append(get_min_bitwise(num))
        return result