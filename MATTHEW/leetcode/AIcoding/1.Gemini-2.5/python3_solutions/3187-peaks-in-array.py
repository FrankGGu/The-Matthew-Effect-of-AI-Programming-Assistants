class Solution:
    def countPeaks(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 3:
            return 0

        peaks_count = 0
        for i in range(1, n - 1):
            if nums[i - 1] < nums[i] and nums[i] > nums[i + 1]:
                peaks_count += 1
        return peaks_count