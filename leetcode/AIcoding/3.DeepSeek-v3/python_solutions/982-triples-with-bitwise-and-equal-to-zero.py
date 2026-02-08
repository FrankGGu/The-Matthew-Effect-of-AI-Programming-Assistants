class Solution:
    def countTriplets(self, nums: List[int]) -> int:
        count = 0
        freq = {}
        for i in nums:
            for j in nums:
                key = i & j
                freq[key] = freq.get(key, 0) + 1

        for k in nums:
            for key in freq:
                if (key & k) == 0:
                    count += freq[key]
        return count