from functools import cmp_to_key

class Solution:
    def largestNumber(self, nums: List[int]) -> str:
        def compare(a, b):
            if a + b > b + a:
                return -1
            else:
                return 1

        nums_str = list(map(str, nums))
        nums_str.sort(key=cmp_to_key(compare))
        result = ''.join(nums_str)
        return result if result[0] != '0' else '0'