class Solution:
    def kConcatenationMaxSum(self, arr: List[int], k: int) -> int:
        MOD = 10**9 + 7

        def kadane(arr):
            max_sum = current_sum = 0
            for num in arr:
                current_sum = max(num, current_sum + num)
                max_sum = max(max_sum, current_sum)
            return max_sum

        if k == 1:
            return kadane(arr) % MOD

        total = sum(arr)
        prefix_sum = suffix_sum = 0
        current_prefix = current_suffix = 0

        for i in range(len(arr)):
            current_prefix += arr[i]
            prefix_sum = max(prefix_sum, current_prefix)

            current_suffix += arr[-i - 1]
            suffix_sum = max(suffix_sum, current_suffix)

        max_single = kadane(arr)
        max_double = kadane(arr + arr)

        if total > 0:
            return max(max_single, max_double, suffix_sum + prefix_sum + (k - 2) * total) % MOD
        else:
            return max(max_single, max_double) % MOD