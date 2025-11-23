class Solution:
    def minAdjacentSwaps(self, nums: List[int]) -> int:
        from collections import deque

        n = len(nums)
        k = nums.count(1)
        ones = [i for i, x in enumerate(nums) if x == 1]

        def get_median(arr):
            return arr[len(arr) // 2]

        def calculate_swaps(arr, m):
            swaps = 0
            for i in range(len(arr)):
                swaps += abs(arr[i] - (m - len(arr) // 2 + i))
            return swaps

        res = float('inf')
        for i in range(len(ones) - k + 1):
            window = ones[i:i + k]
            m = get_median(window)
            swaps = calculate_swaps(window, m)
            res = min(res, swaps)

        return res