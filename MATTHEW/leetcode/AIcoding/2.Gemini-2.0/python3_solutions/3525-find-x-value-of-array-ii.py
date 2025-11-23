class Solution:
    def findXValue(self, nums: List[int]) -> int:
        x = 0
        for num in nums:
            x = x ^ num
        return x