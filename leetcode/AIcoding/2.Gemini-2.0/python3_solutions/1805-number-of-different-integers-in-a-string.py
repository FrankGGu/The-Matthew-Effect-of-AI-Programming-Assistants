import re

class Solution:
    def numDifferentIntegers(self, word: str) -> int:
        nums = set()
        for num_str in re.findall(r'\d+', word):
            num = int(num_str)
            nums.add(num)
        return len(nums)