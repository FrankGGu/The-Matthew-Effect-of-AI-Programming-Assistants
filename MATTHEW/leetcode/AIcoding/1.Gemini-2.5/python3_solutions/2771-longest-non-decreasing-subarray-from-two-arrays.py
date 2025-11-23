class Solution:
    def longestNondecreasingSubarray(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)
        if n == 0:
            return 0
        if n == 1:
            return 1

        # dp1: length of the longest non-decreasing subarray ending at current index, choosing nums1[i]
        # dp2: length of the longest non-decreasing subarray ending at current index, choosing nums2[i]

        # Initialize for index 0
        prev_dp1 = 1
        prev_dp2 = 1
        max_length = 1

        for i in range(1, n):
            current_dp1 = 1
            current_dp2 = 1

            # Calculate current_dp1 (ending with nums1[i])
            if nums1[i] >= nums1[i-1]:
                current_dp1 = max(current_dp1, prev_dp1 + 1)
            if nums1[i] >= nums2[i-1]:
                current_dp1 = max(current_dp1, prev_dp2 + 1)

            # Calculate current_dp2 (ending with nums2[i])
            if nums2[i] >= nums1[i-1]:
                current_dp2 = max(current_dp2, prev_dp1 + 1)
            if nums2[i] >= nums2[i-1]:
                current_dp2 = max(current_dp2, prev_dp2 + 1)

            max_length = max(max_length, current_dp1, current_dp2)

            prev_dp1 = current_dp1
            prev_dp2 = current_dp2

        return max_length