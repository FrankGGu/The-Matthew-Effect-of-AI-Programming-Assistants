class Solution:
    def sortJumbled(self, mapping: List[int], nums: List[int]) -> List[int]:
        def map_num(num):
            if num == 0:
                return mapping[0]
            res = 0
            power = 1
            while num > 0:
                digit = num % 10
                mapped_digit = mapping[digit]
                res += mapped_digit * power
                num = num // 10
                power *= 10
            return res

        mapped_nums = [(map_num(num), i, num) for i, num in enumerate(nums)]
        mapped_nums.sort()
        return [num for (_, _, num) in mapped_nums]