class Solution:
    def numberOfSubarrays(self, nums: List[int]) -> int:
        stack = []
        res = 0
        for num in nums:
            while stack and stack[-1] < num:
                stack.pop()
            if not stack or stack[-1] > num:
                stack.append(num)
            else:
                stack[-1] = num
            res += len(stack)
        return res