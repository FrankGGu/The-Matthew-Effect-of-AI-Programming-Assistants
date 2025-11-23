class Solution:
    def totalSteps(self, nums: List[int]) -> int:
        stack = []
        res = 0
        for num in nums:
            max_t = 0
            while stack and stack[-1][0] <= num:
                max_t = max(max_t, stack.pop()[1])
            if stack:
                max_t += 1
            else:
                max_t = 0
            res = max(res, max_t)
            stack.append((num, max_t))
        return res