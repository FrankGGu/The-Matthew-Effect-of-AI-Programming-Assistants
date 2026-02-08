import re

class Solution:
    def numDifferentIntegers(self, word: str) -> int:
        nums = re.split(r'[a-z]+', word)
        unique_nums = set()
        for num in nums:
            if num:
                unique_nums.add(int(num))
        return len(unique_nums)