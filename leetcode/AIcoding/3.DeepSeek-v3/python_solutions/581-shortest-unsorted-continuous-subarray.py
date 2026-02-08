class Solution:
    def findUnsortedSubarray(self, nums: List[int]) -> int:
        n = len(nums)
        if n <= 1:
            return 0

        left, right = n - 1, 0
        stack = []

        for i in range(n):
            while stack and nums[stack[-1]] > nums[i]:
                left = min(left, stack.pop())
            stack.append(i)

        stack = []
        for i in range(n - 1, -1, -1):
            while stack and nums[stack[-1]] < nums[i]:
                right = max(right, stack.pop())
            stack.append(i)

        return right - left + 1 if right > left else 0