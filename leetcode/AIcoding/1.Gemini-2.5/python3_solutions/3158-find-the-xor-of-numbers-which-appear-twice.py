import collections

class Solution:
    def duplicateNumbersXOR(self, nums: list[int]) -> int:
        counts = collections.Counter(nums)
        xor_sum = 0
        for num, count in counts.items():
            if count == 2:
                xor_sum ^= num
        return xor_sum