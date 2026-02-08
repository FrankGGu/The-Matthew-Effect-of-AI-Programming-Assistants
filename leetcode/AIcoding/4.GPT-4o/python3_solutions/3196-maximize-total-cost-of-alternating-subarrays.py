class Solution:
    def maximumAlternatingSum(self, nums: List[int]) -> int:
        n = len(nums)
        even_sum = [0] * n
        odd_sum = [0] * n

        even_sum[0] = nums[0]

        for i in range(1, n):
            even_sum[i] = max(even_sum[i-1], odd_sum[i-1] + nums[i])
            odd_sum[i] = even_sum[i-1]

        return even_sum[n-1]