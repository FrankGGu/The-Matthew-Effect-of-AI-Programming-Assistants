class Solution:
    def nextGreaterElement(self, nums1: list[int], nums2: list[int]) -> list[int]:
        result = []
        for num1 in nums1:
            found = False
            greater = -1
            for num2 in nums2:
                if num2 == num1:
                    found = True
                elif found and num2 > num1:
                    greater = num2
                    break
            result.append(greater)
        return result