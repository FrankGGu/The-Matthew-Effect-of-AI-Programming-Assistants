class Solution:
    def findKth(self, nums1: List[int], nums2: List[int], k: int) -> int:
        def kth_helper(start1, start2, k):
            if start1 >= len(nums1):
                return nums2[start2 + k - 1]
            if start2 >= len(nums2):
                return nums1[start1 + k - 1]
            if k == 1:
                return min(nums1[start1], nums2[start2])

            mid1 = float('inf') if start1 + k // 2 - 1 >= len(nums1) else nums1[start1 + k // 2 - 1]
            mid2 = float('inf') if start2 + k // 2 - 1 >= len(nums2) else nums2[start2 + k // 2 - 1]

            if mid1 < mid2:
                return kth_helper(start1 + k // 2, start2, k - k // 2)
            else:
                return kth_helper(start1, start2 + k // 2, k - k // 2)

        return kth_helper(0, 0, k)