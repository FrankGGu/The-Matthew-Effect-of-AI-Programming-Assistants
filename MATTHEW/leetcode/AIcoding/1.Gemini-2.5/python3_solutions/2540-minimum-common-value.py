class Solution:
    def getCommon(self, nums1: list[int], nums2: list[int]) -> int:
        ptr1 = 0
        ptr2 = 0
        n1 = len(nums1)
        n2 = len(nums2)

        while ptr1 < n1 and ptr2 < n2:
            if nums1[ptr1] == nums2[ptr2]:
                return nums1[ptr1]
            elif nums1[ptr1] < nums2[ptr2]:
                ptr1 += 1
            else:
                ptr2 += 1

        return -1