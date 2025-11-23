from functools import cmp_to_key

class Solution:
    def largestNumber(self, nums: list[int]) -> str:
        def compare(x, y):
            return 1 if str(x) + str(y) < str(y) + str(x) else -1

        nums = sorted(nums, key=cmp_to_key(compare))
        result = "".join(map(str, nums))
        return "0" if result[0] == "0" else result