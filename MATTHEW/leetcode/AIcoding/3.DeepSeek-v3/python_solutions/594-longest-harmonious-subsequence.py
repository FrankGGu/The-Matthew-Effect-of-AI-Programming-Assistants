from collections import defaultdict

class Solution:
    def findLHS(self, nums: List[int]) -> int:
        freq = defaultdict(int)
        for num in nums:
            freq[num] += 1

        max_length = 0
        for key in freq:
            if key + 1 in freq:
                max_length = max(max_length, freq[key] + freq[key + 1])

        return max_length