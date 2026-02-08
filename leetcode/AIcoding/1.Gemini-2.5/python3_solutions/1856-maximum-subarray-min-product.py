class Solution:
    def maxSumMinProduct(self, nums: list[int]) -> int:
        n = len(nums)

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        max_product = 0
        stack = [] 

        for i in range(n):
            while stack and nums[stack[-1]] >= nums[i]:
                j = stack.pop()

                left_boundary = stack[-1] if stack else -1

                current_sum = prefix_sum[i] - prefix_sum[left_boundary + 1]

                max_product = max(max_product, nums[j] * current_sum)

            stack.append(i)

        while stack:
            j = stack.pop()

            left_boundary = stack[-1] if stack else -1

            current_sum = prefix_sum[n] - prefix_sum[left_boundary + 1]

            max_product = max(max_product, nums[j] * current_sum)

        return max_product % (10**9 + 7)