class Solution:
    def maxArrayValue(self, nums: List[int]) -> int:
        n = len(nums)
        stack = []
        for num in nums:
            stack.append(num)
            while len(stack) >= 2 and stack[-1] >= stack[-2]:
                x = stack.pop()
                y = stack.pop()
                stack.append(x + y)
        return max(stack)