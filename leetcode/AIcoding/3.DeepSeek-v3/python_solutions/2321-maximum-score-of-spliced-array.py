class Solution:
    def maximumsSplicedArray(self, nums1: List[int], nums2: List[int]) -> int:
        def kadane(a, b):
            max_diff = current = 0
            for x, y in zip(a, b):
                current = max(y - x, current + y - x)
                max_diff = max(max_diff, current)
            return max_diff + sum(a)

        return max(kadane(nums1, nums2), kadane(nums2, nums1))