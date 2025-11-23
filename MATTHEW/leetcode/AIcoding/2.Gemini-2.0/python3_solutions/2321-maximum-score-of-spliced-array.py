class Solution:
    def maximumsSplicedArray(self, nums1: List[int], nums2: List[int]) -> int:
        def solve(arr1, arr2):
            total_sum = sum(arr1)
            max_diff = 0
            curr_diff = 0
            for i in range(len(arr1)):
                curr_diff += arr2[i] - arr1[i]
                max_diff = max(max_diff, curr_diff)
                curr_diff = max(curr_diff, 0)
            return total_sum + max_diff

        return max(solve(nums1, nums2), solve(nums2, nums1))