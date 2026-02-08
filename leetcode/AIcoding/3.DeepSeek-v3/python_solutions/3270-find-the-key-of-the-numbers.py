class Solution:
    def findTheKey(self, nums: List[int]) -> int:
        key = 0
        for num in nums:
            key ^= num
        return key