class Solution:
    def minSwap(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        swap, not_swap = 1, 0

        for i in range(1, n):
            new_swap = new_not_swap = float('inf')
            if nums1[i] > nums1[i-1] and nums2[i] > nums2[i-1]:
                new_swap = min(new_swap, swap + 1)
                new_not_swap = min(new_not_swap, not_swap)
            if nums1[i] > nums2[i-1] and nums2[i] > nums1[i-1]:
                new_swap = min(new_swap, not_swap + 1)
                new_not_swap = min(new_not_swap, swap)
            swap, not_swap = new_swap, new_not_swap

        return min(swap, not_swap)