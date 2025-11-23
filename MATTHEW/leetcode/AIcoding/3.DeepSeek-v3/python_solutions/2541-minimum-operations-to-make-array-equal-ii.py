class Solution:
    def minOperations(self, nums1: List[int], nums2: List[int], k: int) -> int:
        if k == 0:
            return 0 if nums1 == nums2 else -1

        total_add = 0
        total_sub = 0

        for a, b in zip(nums1, nums2):
            diff = a - b
            if diff % k != 0:
                return -1
            if diff > 0:
                total_sub += diff // k
            else:
                total_add += -diff // k

        if total_add == total_sub:
            return total_add
        else:
            return -1