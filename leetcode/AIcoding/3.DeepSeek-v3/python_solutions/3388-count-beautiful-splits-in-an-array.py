class Solution:
    def beautifulSubarrays(self, nums: List[int]) -> int:
        prefix = 0
        count = 0
        freq = {0: 1}

        for num in nums:
            prefix ^= num
            count += freq.get(prefix, 0)
            freq[prefix] = freq.get(prefix, 0) + 1

        return count