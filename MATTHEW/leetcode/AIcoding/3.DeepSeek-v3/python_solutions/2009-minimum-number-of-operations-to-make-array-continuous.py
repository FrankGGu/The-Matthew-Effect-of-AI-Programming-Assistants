class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        unique_sorted = sorted(set(nums))
        res = float('inf')
        m = len(unique_sorted)

        for i in range(m):
            left = unique_sorted[i]
            right = left + n - 1
            j = bisect.bisect_right(unique_sorted, right)
            res = min(res, n - (j - i))

        return res