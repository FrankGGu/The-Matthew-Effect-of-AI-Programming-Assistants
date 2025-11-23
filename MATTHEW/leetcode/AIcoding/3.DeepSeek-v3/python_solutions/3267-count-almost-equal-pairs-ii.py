class Solution:
    def countAlmostEqualPairs(self, nums: List[int]) -> int:
        count = 0
        freq = {}
        for num in nums:
            for key in freq:
                if abs(key - num) <= 1:
                    count += freq[key]
            freq[num] = freq.get(num, 0) + 1
        return count