class Solution:
    def maxSubarrayMinProduct(self, nums: list[int]) -> int:
        n = len(nums)
        stack = []
        left = [0] * n
        right = [0] * n
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]
        for i in range(n):
            while stack and nums[stack[-1]] >= nums[i]:
                stack.pop()
            if stack:
                left[i] = stack[-1] + 1
            else:
                left[i] = 0
            stack.append(i)
        stack = []
        for i in range(n - 1, -1, -1):
            while stack and nums[stack[-1]] >= nums[i]:
                stack.pop()
            if stack:
                right[i] = stack[-1] - 1
            else:
                right[i] = n - 1
            stack.append(i)
        max_product = 0
        for i in range(n):
            product = nums[i] * (prefix_sum[right[i] + 1] - prefix_sum[left[i]])
            max_product = max(max_product, product)
        return max_product % (10**9 + 7)