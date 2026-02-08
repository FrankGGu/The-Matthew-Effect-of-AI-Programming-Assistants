class Solution:
    def maxDistance(self, nums1: list[int], nums2: list[int]) -> int:
        n1 = len(nums1)
        n2 = len(nums2)

        i = 0  # Pointer for nums1
        j = 0  # Pointer for nums2
        max_dist = 0

        while i < n1 and j < n2:
            if nums1[i] <= nums2[j]:
                # This is a valid pair (i, j) as nums1[i] <= nums2[j] and j >= i (due to j = max(j, i) logic)
                # We want to maximize j - i.
                # For the current i, we try to find the largest possible j.
                # Since nums2 is non-increasing, if nums1[i] <= nums2[j], it's possible
                # nums1[i] <= nums2[j+1] as well. So, we advance j to explore larger distances.
                max_dist = max(max_dist, j - i)
                j += 1
            else:
                # nums1[i] > nums2[j]. This pair is not valid.
                # Since nums1 is non-increasing, nums1[i+1] will be smaller or equal.
                # Since nums2 is non-increasing, nums2[j] is the largest value available at or before j.
                # To satisfy nums1[i'] <= nums2[j'], we must either decrease nums1[i'] (by incrementing i)
                # or increase nums2[j'] (which is not possible by incrementing j, as nums2 values are non-increasing).
                # So, we must advance i.
                i += 1
                # After advancing i, we must ensure j >= i.
                # If j is now less than i, we advance j to i.
                j = max(j, i)

        return max_dist