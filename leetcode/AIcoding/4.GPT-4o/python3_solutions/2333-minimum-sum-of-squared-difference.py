class Solution:
    def minSumSquareDiff(self, nums1: List[int], nums2: List[int], k: int) -> int:
        diffs = sorted(abs(a - b) for a, b in zip(nums1, nums2))
        total_diff = sum(diffs)

        for i in range(len(diffs) - 1, -1, -1):
            if k <= 0:
                break
            reduce = min(k, diffs[i])
            diffs[i] -= reduce
            k -= reduce

        return sum(d ** 2 for d in diffs)