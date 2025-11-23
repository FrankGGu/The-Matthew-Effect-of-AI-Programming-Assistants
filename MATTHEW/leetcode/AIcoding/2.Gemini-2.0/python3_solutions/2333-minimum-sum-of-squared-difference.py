class Solution:
    def minSumSquareDiff(self, nums1: List[int], nums2: List[int], k1: int, k2: int) -> int:
        diffs = [abs(nums1[i] - nums2[i]) for i in range(len(nums1))]

        total_k = k1 + k2

        diffs.sort(reverse=True)

        for i in range(len(diffs)):
            reduction = min(diffs[i], total_k)
            diffs[i] -= reduction
            total_k -= reduction
            if total_k == 0:
                break

        return sum(d * d for d in diffs)