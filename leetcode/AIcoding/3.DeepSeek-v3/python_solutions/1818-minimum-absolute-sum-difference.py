class Solution:
    def minAbsoluteSumDiff(self, nums1: List[int], nums2: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums1)
        sorted_nums1 = sorted(nums1)
        total = 0
        max_reduction = 0

        for i in range(n):
            diff = abs(nums1[i] - nums2[i])
            total += diff

            left, right = 0, n - 1
            while left < right:
                mid = (left + right) // 2
                if sorted_nums1[mid] < nums2[i]:
                    left = mid + 1
                else:
                    right = mid
            closest = sorted_nums1[left]
            if left > 0:
                closest = min(closest, sorted_nums1[left - 1])
            max_reduction = max(max_reduction, diff - abs(closest - nums2[i]))

        return (total - max_reduction) % MOD