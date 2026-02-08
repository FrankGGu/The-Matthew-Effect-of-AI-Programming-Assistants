class Solution:
    def twoOutOfThree(self, nums1: List[int], nums2: List[int], nums3: List[int]) -> List[int]:
        set1 = set(nums1)
        set2 = set(nums2)
        set3 = set(nums3)
        result = set()
        result.update(set1 & set2)
        result.update(set2 & set3)
        result.update(set1 & set3)
        return list(result)