class Solution:
    def xorOperation(self, n: int, start: int) -> int:
        nums = [start + 2 * i for i in range(n)]
        xor_sum = 0
        for num in nums:
            xor_sum ^= num
        return xor_sum