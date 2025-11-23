class Solution:
    def numberOfGoodPairs(self, nums1: list[int], nums2: list[int], k: int) -> int:
        n = len(nums1)
        count = 0
        for i in range(n):
            for j in range(n):
                if nums1[i] % (nums2[j] * k) == 0:
                    count += 1
        return count