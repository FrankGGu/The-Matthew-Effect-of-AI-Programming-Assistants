import math

class Solution:
    def thirdMax(self, nums: list[int]) -> int:
        max1 = -math.inf
        max2 = -math.inf
        max3 = -math.inf

        for num in nums:
            if num > max1:
                max3 = max2
                max2 = max1
                max1 = num
            elif num == max1:
                continue
            elif num > max2:
                max3 = max2
                max2 = num
            elif num == max2:
                continue
            elif num > max3:
                max3 = num

        if max3 == -math.inf:
            return max1
        else:
            return max3