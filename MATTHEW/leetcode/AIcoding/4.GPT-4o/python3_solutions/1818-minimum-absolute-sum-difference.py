class Solution:
    def minimumAbsoluteSumDifference(self, nums1: List[int], nums2: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums1)
        total_diff = sum(abs(x - y) for x, y in zip(nums1, nums2))
        sorted_nums1 = sorted(nums1)
        min_diff = total_diff

        for y in nums2:
            idx = bisect.bisect_left(sorted_nums1, y)
            if idx < n:
                min_diff = min(min_diff, total_diff - abs(nums1[idx] - y) + abs(sorted_nums1[idx] - y))
            if idx > 0:
                min_diff = min(min_diff, total_diff - abs(nums1[idx - 1] - y) + abs(sorted_nums1[idx - 1] - y))

        return min_diff % MOD