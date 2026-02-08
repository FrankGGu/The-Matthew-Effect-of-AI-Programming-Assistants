class Solution:
    def singleNumber(self, nums: List[int]) -> List[int]:
        xor = 0
        for num in nums:
            xor ^= num

        rightmost_set_bit = xor & -xor

        first_num = 0
        second_num = 0

        for num in nums:
            if num & rightmost_set_bit:
                first_num ^= num
            else:
                second_num ^= num

        return [first_num, second_num]