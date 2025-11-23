class Solution:
    def countMaxFrequency(self, nums: List[int]) -> int:
        frequency = Counter(nums)
        max_freq = max(frequency.values())
        return sum(1 for count in frequency.values() if count == max_freq)