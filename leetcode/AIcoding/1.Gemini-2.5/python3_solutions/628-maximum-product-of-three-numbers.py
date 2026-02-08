import math

class Solution:
    def maximumProduct(self, nums: list[int]) -> int:
        nums.sort()
        n = len(nums)

        # Option 1: Product of the three largest numbers
        product1 = nums[n-1] * nums[n-2] * nums[n-3]

        # Option 2: Product of the two smallest (most negative) numbers and the largest number
        product2 = nums[0] * nums[1] * nums[n-1]

        return max(product1, product2)