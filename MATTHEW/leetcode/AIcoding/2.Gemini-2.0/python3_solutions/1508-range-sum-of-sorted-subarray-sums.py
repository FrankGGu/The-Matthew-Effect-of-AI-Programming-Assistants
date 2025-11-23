class Solution:
    def rangeSum(self, nums: list[int], n: int, left: int, right: int) -> int:
        sub_sums = []
        for i in range(n):
            curr_sum = 0
            for j in range(i, n):
                curr_sum += nums[j]
                sub_sums.append(curr_sum)

        sub_sums.sort()

        total_sum = 0
        for i in range(left - 1, right):
            total_sum = (total_sum + sub_sums[i]) % (10**9 + 7)

        return total_sum