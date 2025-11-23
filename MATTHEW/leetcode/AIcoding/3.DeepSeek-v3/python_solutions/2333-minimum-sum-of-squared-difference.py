class Solution:
    def minSumSquareDiff(self, nums1: List[int], nums2: List[int], k1: int, k2: int) -> int:
        diffs = [abs(a - b) for a, b in zip(nums1, nums2)]
        max_diff = max(diffs) if diffs else 0
        bucket = [0] * (max_diff + 1)
        for d in diffs:
            bucket[d] += 1

        k = k1 + k2

        for i in range(max_diff, 0, -1):
            if k == 0:
                break
            if bucket[i] > 0:
                subtract = min(k, bucket[i])
                bucket[i] -= subtract
                bucket[i - 1] += subtract
                k -= subtract

        res = 0
        for i in range(max_diff, 0, -1):
            res += bucket[i] * i * i
        return res