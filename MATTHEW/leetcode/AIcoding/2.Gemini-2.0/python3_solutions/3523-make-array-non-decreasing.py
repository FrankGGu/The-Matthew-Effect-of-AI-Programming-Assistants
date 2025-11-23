class Solution:
    def makeArrayNonDecreasing(self, nums: list[int]) -> int:
        stack = []
        res = 0
        for num in nums:
            count = 0
            while stack and stack[-1] > num:
                stack.pop()
                count += 1
            while count > 0:
                stack.append(num)
                count -= 1
                res += 1
            stack.append(num)
        return res