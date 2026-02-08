class Solution:
    def findPeaks(self, nums: list[int]) -> list[int]:
        peaks_indices = []
        n = len(nums)
        for i in range(1, n - 1):
            if nums[i] > nums[i-1] and nums[i] > nums[i+1]:
                peaks_indices.append(i)
        return peaks_indices