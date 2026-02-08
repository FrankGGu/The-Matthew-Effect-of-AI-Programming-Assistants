class Solution:
    def maxFrequencyElements(self, nums: List[int]) -> int:
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1
        max_freq = max(freq.values())
        count = sum(v for v in freq.values() if v == max_freq)
        return count * max_freq