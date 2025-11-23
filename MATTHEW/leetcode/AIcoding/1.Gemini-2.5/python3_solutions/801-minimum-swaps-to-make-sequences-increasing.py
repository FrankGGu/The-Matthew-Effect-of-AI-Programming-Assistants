import math

class Solution:
    def minSwap(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)

        no_swap_prev = 0
        swap_prev = 1

        for i in range(1, n):
            no_swap_curr = math.inf
            swap_curr = math.inf

            # Case: No swap at current index i (nums1[i], nums2[i])
            # Option A: Previous index (i-1) was not swapped (nums1[i-1], nums2[i-1])
            if nums1[i-1] < nums1[i] and nums2[i-1] < nums2[i]:
                no_swap_curr = min(no_swap_curr, no_swap_prev)

            # Option B: Previous index (i-1) was swapped (nums2[i-1], nums1[i-1])
            if nums2[i-1] < nums1[i] and nums1[i-1] < nums2[i]:
                no_swap_curr = min(no_swap_curr, swap_prev)

            # Case: Swap at current index i (nums2[i], nums1[i])
            # Option A: Previous index (i-1) was not swapped (nums1[i-1], nums2[i-1])
            if nums1[i-1] < nums2[i] and nums2[i-1] < nums1[i]:
                swap_curr = min(swap_curr, no_swap_prev + 1)

            # Option B: Previous index (i-1) was swapped (nums2[i-1], nums1[i-1])
            if nums2[i-1] < nums2[i] and nums1[i-1] < nums1[i]:
                swap_curr = min(swap_curr, swap_prev + 1)

            no_swap_prev = no_swap_curr
            swap_prev = swap_curr

        return min(no_swap_prev, swap_prev)