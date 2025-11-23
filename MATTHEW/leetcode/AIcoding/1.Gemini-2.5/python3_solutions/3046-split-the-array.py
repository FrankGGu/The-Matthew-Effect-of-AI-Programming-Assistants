class Solution:
    def splitArray(self, nums: list[int]) -> bool:
        n = len(nums)
        mid = n // 2

        nums1 = nums[:mid]
        nums2 = nums[mid:]

        is_nums1_good = len(set(nums1)) == len(nums1)
        is_nums2_good = len(set(nums2)) == len(nums2)

        return is_nums1_good and is_nums2_good