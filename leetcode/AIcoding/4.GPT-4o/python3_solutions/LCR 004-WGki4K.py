class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        count = [0] * 32
        for num in nums:
            for i in range(32):
                count[i] += (num >> i) & 1
        result = 0
        for i in range(32):
            if count[i] % 3:
                result |= (1 << i)
        return result if result < 2**31 else result - 2**32