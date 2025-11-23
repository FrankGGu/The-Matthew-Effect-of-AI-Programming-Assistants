from collections import defaultdict

class Solution:
    def countGoodPairs(self, nums: List[int]) -> int:
        count = 0
        freq = defaultdict(int)
        for num in nums:
            count += freq[num]
            freq[num] += 1
        return count