from typing import List

class Solution:
    def findStableMountains(self, nums: List[int]) -> List[int]:
        n = len(nums)
        if n < 3:
            return []

        min_left_val = [0] * n
        min_left_val[0] = nums[0]
        for i in range(1, n):
            if nums[i-1] < nums[i]:
                min_left_val[i] = min_left_val[i-1]
            else:
                min_left_val[i] = nums[i]

        min_right_val = [0] * n
        min_right_val[n-1] = nums[n-1]
        for i in range(n - 2, -1, -1):
            if nums[i] > nums[i+1]:
                min_right_val[i] = min_right_val[i+1]
            else:
                min_right_val[i] = nums[i]

        result = []
        for i in range(1, n - 1):
            # Check if nums[i] is a peak
            if nums[i-1] < nums[i] and nums[i] > nums[i+1]:
                # Check if the mountain is stable
                if min_left_val[i] == min_right_val[i]:
                    result.append(i)

        return result