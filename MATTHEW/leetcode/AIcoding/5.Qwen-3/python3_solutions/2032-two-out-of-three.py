class Solution:
    def twoOutOfThree(self, nums1: List[int], nums2: List[int], nums3: List[int]) -> List[int]:
        set1 = set(nums1)
        set2 = set(nums2)
        set3 = set(nums3)
        result = []
        for num in set1:
            if num in set2 or num in set3:
                result.append(num)
        for num in set2:
            if num in set1 or num in set3:
                result.append(num)
        for num in set3:
            if num in set1 or num in set2:
                result.append(num)
        return result