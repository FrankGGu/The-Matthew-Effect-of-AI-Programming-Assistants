class Solution:
    def minimumPairRemoval(self, nums: List[int]) -> int:
        stack = []
        for num in nums:
            if not stack or num >= stack[-1]:
                stack.append(num)
            else:
                stack.pop()
        return len(nums) - len(stack)