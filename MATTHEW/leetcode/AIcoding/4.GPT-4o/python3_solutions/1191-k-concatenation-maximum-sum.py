class Solution:
    def kConcatenationMaxSum(self, arr: List[int], k: int) -> int:
        mod = 10**9 + 7

        def kadane(arr):
            max_ending_here = max_so_far = 0
            for x in arr:
                max_ending_here = max(0, max_ending_here + x)
                max_so_far = max(max_so_far, max_ending_here)
            return max_so_far

        if k == 1:
            return kadane(arr) % mod

        total_sum = sum(arr)
        max_kadane = kadane(arr)

        if total_sum > 0:
            return max(max_kadane, max_kadane + (k - 1) * total_sum) % mod
        else:
            return max_kadane % mod