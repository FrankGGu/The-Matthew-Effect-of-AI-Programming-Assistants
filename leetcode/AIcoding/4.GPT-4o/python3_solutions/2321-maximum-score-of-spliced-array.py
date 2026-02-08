class Solution:
    def maximumScore(self, nums1: List[int], nums2: List[int]) -> int:
        total1 = sum(nums1)
        total2 = sum(nums2)
        max_score = total1 + total2

        max_diff1 = max_diff2 = 0

        for i in range(len(nums1)):
            max_diff1 = max(max_diff1, nums2[i] - nums1[i])

        for i in range(len(nums2)):
            max_diff2 = max(max_diff2, nums1[i] - nums2[i])

        return max(max_score - max_diff1, max_score - max_diff2)