class Solution:
    def maxSumMinProduct(self, nums: List[int]) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        stack = []
        max_product = 0

        for i in range(n + 1):
            while stack and (i == n or nums[stack[-1]] > nums[i]):
                j = stack.pop()
                left = stack[-1] if stack else -1
                product = nums[j] * (prefix_sum[i] - prefix_sum[left + 1])
                max_product = max(max_product, product)
            stack.append(i)

        return max_product % (10**9 + 7)