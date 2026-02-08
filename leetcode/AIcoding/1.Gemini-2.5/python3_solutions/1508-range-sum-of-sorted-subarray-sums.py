import heapq

class Solution:
    def rangeSum(self, nums: list[int], n: int, left: int, right: int) -> int:
        all_subarray_sums = []
        for i in range(n):
            current_sum = 0
            for j in range(i, n):
                current_sum += nums[j]
                all_subarray_sums.append(current_sum)

        all_subarray_sums.sort()

        MOD = 10**9 + 7
        total_sum = 0

        for k in range(left - 1, right):
            total_sum = (total_sum + all_subarray_sums[k]) % MOD

        return total_sum