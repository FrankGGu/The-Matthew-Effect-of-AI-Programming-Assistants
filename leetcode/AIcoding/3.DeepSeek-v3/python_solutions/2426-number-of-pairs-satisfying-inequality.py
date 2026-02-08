class Solution:
    def numberOfPairs(self, nums1: List[int], nums2: List[int], diff: int) -> int:
        import bisect
        arr = []
        res = 0
        for a, b in zip(nums1, nums2):
            target = a - b + diff
            idx = bisect.bisect_right(arr, target)
            res += idx
            val = a - b
            bisect.insort(arr, val)
        return res