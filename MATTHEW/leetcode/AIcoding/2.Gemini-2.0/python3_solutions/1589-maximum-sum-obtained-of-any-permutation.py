class Solution:
    def maxSumRangeQuery(self, nums: List[int], requests: List[List[int]]) -> int:
        n = len(nums)
        diff = [0] * (n + 1)
        for start, end in requests:
            diff[start] += 1
            diff[end + 1] -= 1

        prefix_sum = [0] * n
        prefix_sum[0] = diff[0]
        for i in range(1, n):
            prefix_sum[i] = prefix_sum[i - 1] + diff[i]

        prefix_sum.sort(reverse=True)
        nums.sort(reverse=True)

        max_sum = 0
        for i in range(n):
            max_sum = (max_sum + prefix_sum[i] * nums[i]) % (10**9 + 7)

        return max_sum