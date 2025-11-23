class Solution:
    def constructMinimumBitwiseArray(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [0] * n
        stack = []

        for i in range(n):
            while stack and nums[stack[-1]] > nums[i]:
                stack.pop()
            if stack:
                res[i] = nums[stack[-1]]
            else:
                res[i] = -1
            stack.append(i)

        return res