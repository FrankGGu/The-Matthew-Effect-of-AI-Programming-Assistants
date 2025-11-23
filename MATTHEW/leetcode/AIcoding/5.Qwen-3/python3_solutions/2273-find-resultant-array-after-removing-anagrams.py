from typing import List

class Solution:
    def removeAnagrams(self, nums: List[int]) -> List[int]:
        result = []
        prev = None
        for num in nums:
            current = str(num)
            if prev is None or sorted(current) != sorted(prev):
                result.append(num)
                prev = current
        return result