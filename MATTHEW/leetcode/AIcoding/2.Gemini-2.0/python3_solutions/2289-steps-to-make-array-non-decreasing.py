class Solution:
    def totalSteps(self, nums: List[int]) -> int:
        stack = []
        ans = 0
        for num in nums:
            count = 0
            while stack and num >= stack[-1][0]:
                count = max(count, stack.pop()[1])
            if stack:
                count += 1
            else:
                count = 0
            ans = max(ans, count)
            stack.append((num, count))
        return ans