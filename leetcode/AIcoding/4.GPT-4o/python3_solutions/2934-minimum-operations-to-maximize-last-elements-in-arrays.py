class Solution:
    def minOperations(self, nums: List[int], numsDivide: List[int]) -> int:
        g = reduce(gcd, numsDivide)
        nums.sort()
        for i, num in enumerate(nums):
            if g % num == 0:
                return i
        return len(nums)