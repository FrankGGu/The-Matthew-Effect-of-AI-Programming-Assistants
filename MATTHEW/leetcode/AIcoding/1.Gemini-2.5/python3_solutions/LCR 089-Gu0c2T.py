class Solution:
    def rob(self, nums: list[int]) -> int:
        rob1 = 0
        rob2 = 0

        for n in nums:
            temp = max(rob2, rob1 + n)
            rob1 = rob2
            rob2 = temp
        return rob2