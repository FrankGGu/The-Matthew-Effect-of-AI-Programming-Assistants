class Solution:
    def sortJumbled(self, mapping: List[int], nums: List[int]) -> List[int]:
        def map_num(num):
            s = str(num)
            mapped_s = "".join(str(mapping[int(digit)]) for digit in s)
            return int(mapped_s)

        mapped_nums = [(map_num(num), num) for num in nums]
        mapped_nums.sort()

        return [num for _, num in mapped_nums]