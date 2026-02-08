class Solution:
    def minSwap(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)
        swap = [float('inf')] * n
        no_swap = [float('inf')] * n
        swap[0] = 1
        no_swap[0] = 0

        for i in range(1, n):
            if nums1[i] > nums1[i - 1] and nums2[i] > nums2[i - 1]:
                no_swap[i] = no_swap[i - 1]
                swap[i] = swap[i - 1] + 1

            if nums1[i] > nums2[i - 1] and nums2[i] > nums1[i - 1]:
                no_swap[i] = min(no_swap[i], swap[i - 1])
                swap[i] = min(swap[i], no_swap[i - 1] + 1)

        return min(swap[n - 1], no_swap[n - 1])