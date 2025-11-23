class Solution:
    def maxFrequencyAfterOperations(self, nums: List[int]) -> int:
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        max_freq = max(freq.values()) if freq else 0

        if max_freq == len(nums):
            return max_freq

        if max_freq == len(nums) - 1:
            return max_freq

        return max_freq + 1