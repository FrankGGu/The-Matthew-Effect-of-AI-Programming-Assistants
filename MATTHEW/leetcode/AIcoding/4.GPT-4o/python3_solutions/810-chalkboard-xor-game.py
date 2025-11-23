class Solution:
    def xorGame(self, nums: List[int]) -> bool:
        return reduce(xor, nums) == 0 or len(nums) % 2 == 0