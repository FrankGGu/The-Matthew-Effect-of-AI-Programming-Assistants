class Solution:
    def findIntersectionValues(self, nums1: list[int], nums2: list[int]) -> list[int]:
        set1 = set(nums1)
        set2 = set(nums2)

        count1 = 0
        for x in nums1:
            if x in set2:
                count1 += 1

        count2 = 0
        for x in nums2:
            if x in set1:
                count2 += 1

        return [count1, count2]