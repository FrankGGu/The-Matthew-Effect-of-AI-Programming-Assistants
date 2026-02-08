class Solution:
    def canTransform(self, nums1: List[int], nums2: List[int]) -> bool:
        n = len(nums1)
        if nums1.count(0) != nums2.count(0):
            return False

        i, j = 0, 0
        while i < n and j < n:
            if nums1[i] == 0:
                i += 1
                continue
            if nums2[j] == 0:
                j += 1
                continue

            if nums1[i] != nums2[j]:
                return False

            if nums1[i] > 0:
                if i > j:
                    return False
            else:
                if i < j:
                    return False

            i += 1
            j += 1

        return True