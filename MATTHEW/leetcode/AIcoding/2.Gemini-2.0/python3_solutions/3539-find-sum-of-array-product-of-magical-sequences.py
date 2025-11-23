class Solution:
    def sumOfArrayProducts(self, nums: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        stack = []
        left = [1] * n
        right = [1] * n

        for i in range(n):
            while stack and nums[stack[-1]] >= nums[i]:
                stack.pop()
            left[i] = i - (stack[-1] if stack else -1)
            stack.append(i)

        stack = []
        for i in range(n - 1, -1, -1):
            while stack and nums[stack[-1]] > nums[i]:
                stack.pop()
            right[i] = (stack[-1] if stack else n) - i
            stack.append(i)

        ans = 0
        for i in range(n):
            ans = (ans + nums[i] * left[i] * right[i]) % MOD

        return ans