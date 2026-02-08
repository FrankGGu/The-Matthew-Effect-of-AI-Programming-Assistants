class Solution:
    def findLastVisited(self, nums):
        result = []
        stack = []

        for num in nums:
            while stack and stack[-1] < num:
                stack.pop()
            stack.append(num)
            result.append(len(stack) - 1)

        return result