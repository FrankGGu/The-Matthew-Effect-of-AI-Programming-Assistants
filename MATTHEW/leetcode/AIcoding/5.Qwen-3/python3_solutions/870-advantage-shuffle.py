class Solution:
    def advantageShuffle(self, nums1: List[int], nums2: int) -> List[int]:
        from collections import deque

        sorted_nums1 = sorted(nums1)
        sorted_indices = sorted(range(len(nums2)), key=lambda i: nums2[i])
        result = [0] * len(nums1)
        left = 0
        right = len(nums1) - 1

        for i in reversed(range(len(sorted_indices))):
            idx = sorted_indices[i]
            if sorted_nums1[right] > nums2[idx]:
                result[idx] = sorted_nums1[right]
                right -= 1
            else:
                result[idx] = sorted_nums1[left]
                left += 1

        return result