import bisect

class Solution:
    def minAbsoluteSumDiff(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)
        MOD = 10**9 + 7

        sorted_nums1 = sorted(nums1)

        total_sum_diff = 0
        max_improvement = 0

        for i in range(n):
            current_diff = abs(nums1[i] - nums2[i])
            total_sum_diff = (total_sum_diff + current_diff) % MOD

            # Find the best replacement for nums1[i] from sorted_nums1
            # which minimizes |replacement - nums2[i]|

            # Use bisect_left to find insertion point for nums2[i] in sorted_nums1
            idx = bisect.bisect_left(sorted_nums1, nums2[i])

            min_new_diff = current_diff # Initialize with current_diff as a fallback

            # Check element at idx (if it exists)
            # This is the smallest element >= nums2[i]
            if idx < n:
                new_diff = abs(sorted_nums1[idx] - nums2[i])
                min_new_diff = min(min_new_diff, new_diff)

            # Check element at idx - 1 (if it exists)
            # This is the largest element <= nums2[i]
            if idx > 0:
                new_diff = abs(sorted_nums1[idx - 1] - nums2[i])
                min_new_diff = min(min_new_diff, new_diff)

            # Calculate the potential improvement for this specific index i
            # The improvement is current_diff - min_new_diff
            # We want to maximize this improvement over all i
            max_improvement = max(max_improvement, current_diff - min_new_diff)

        # The final result is the initial total sum minus the maximum possible improvement.
        # Add MOD before taking modulo to handle potential negative results
        # if total_sum_diff - max_improvement is negative.
        return (total_sum_diff - max_improvement + MOD) % MOD