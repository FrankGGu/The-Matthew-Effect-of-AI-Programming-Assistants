class Solution:
    def xorGame(self, nums: List[int]) -> bool:
        n = len(nums)
        if n % 2 == 0:
            return True
        xor_sum = 0
        for num in nums:
            xor_sum ^= num
        return xor_sum == 0