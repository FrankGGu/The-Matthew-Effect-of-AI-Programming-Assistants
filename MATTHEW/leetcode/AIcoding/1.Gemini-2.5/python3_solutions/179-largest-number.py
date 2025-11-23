import functools

class Solution:
    def largestNumber(self, nums: list[int]) -> str:
        str_nums = [str(num) for num in nums]

        def compare_strings(n1: str, n2: str) -> int:
            if n1 + n2 > n2 + n1:
                return -1
            elif n1 + n2 < n2 + n1:
                return 1
            else:
                return 0

        str_nums.sort(key=functools.cmp_to_key(compare_strings))

        result = "".join(str_nums)

        if result[0] == '0':
            return "0"

        return result