class Solution:
    def nextGreaterElements(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [-1] * n
        stack1 = []
        stack2 = []

        for i in range(n):
            while stack2 and nums[stack2[-1]] < nums[i]:
                stack2.pop()

            while stack1 and nums[stack1[-1]] < nums[i]:
                idx = stack1.pop()
                if not stack2:
                    res[idx] = nums[i]

            stack1.append(i)
            stack2.append(i)

        return res