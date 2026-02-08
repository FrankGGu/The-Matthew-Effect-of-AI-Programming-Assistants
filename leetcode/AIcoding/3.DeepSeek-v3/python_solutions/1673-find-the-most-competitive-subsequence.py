class Solution:
    def mostCompetitive(self, nums: List[int], k: int) -> List[int]:
        stack = []
        n = len(nums)
        for i in range(n):
            while stack and nums[i] < stack[-1] and len(stack) + (n - i) > k:
                stack.pop()
            if len(stack) < k:
                stack.append(nums[i])
        return stack