class Solution:
    def canDivideIntoSubarrays(self, nums: List[int], k: int) -> bool:
        from collections import defaultdict
        freq = defaultdict(int)
        max_freq = 0
        for num in nums:
            freq[num] += 1
            max_freq = max(max_freq, freq[num])
        return max_freq <= k