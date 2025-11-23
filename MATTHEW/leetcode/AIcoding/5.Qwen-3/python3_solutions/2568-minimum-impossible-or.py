class Solution:
    def minImpossibleOR(self, nums: List[int]) -> int:
        s = set(nums)
        for i in range(32):
            if (1 << i) not in s:
                return 1 << i
        return 1 << 32