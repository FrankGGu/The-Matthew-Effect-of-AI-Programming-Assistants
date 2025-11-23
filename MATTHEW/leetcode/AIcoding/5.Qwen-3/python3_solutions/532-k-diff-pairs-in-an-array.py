from collections import Counter

class Solution:
    def findPairs(self, nums: List[int], k: int) -> int:
        count = Counter(nums)
        result = 0
        for num in count:
            if k > 0 and num + k in count:
                result += 1
            elif k == 0 and count[num] > 1:
                result += 1
        return result