class Solution:
    def minOperations(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        if n == 1:
            return 0

        def compute(x1, x2, y1, y2):
            res = 0
            if x1 <= x2 and y1 <= y2:
                return res
            if x1 > x2 and y1 > y2:
                return 1
            return float('inf')

        # Case 1: do not swap last elements
        res1 = 0
        valid1 = True
        for i in range(n - 1):
            x1, x2 = nums1[i], nums1[-1]
            y1, y2 = nums2[i], nums2[-1]
            ops = compute(x1, x2, y1, y2)
            if ops == float('inf'):
                valid1 = False
                break
            res1 += ops

        # Case 2: swap last elements
        res2 = 1
        valid2 = True
        for i in range(n - 1):
            x1, x2 = nums1[i], nums2[-1]
            y1, y2 = nums2[i], nums1[-1]
            ops = compute(x1, x2, y1, y2)
            if ops == float('inf'):
                valid2 = False
                break
            res2 += ops

        if not valid1 and not valid2:
            return -1
        elif valid1 and valid2:
            return min(res1, res2)
        elif valid1:
            return res1
        else:
            return res2