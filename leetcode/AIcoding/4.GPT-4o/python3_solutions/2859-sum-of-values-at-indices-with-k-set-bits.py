class Solution:
    def sumIndicesWithKSetBits(self, nums: List[int], k: int) -> int:
        def count_set_bits(x):
            return bin(x).count('1')

        return sum(i for i in range(len(nums)) if count_set_bits(i) == k)