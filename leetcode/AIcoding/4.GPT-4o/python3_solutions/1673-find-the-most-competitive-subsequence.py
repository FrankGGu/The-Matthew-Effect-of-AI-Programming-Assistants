from collections import deque

class Solution:
    def mostCompetitive(self, nums: List[int], k: int) -> List[int]:
        stack = deque()
        to_pop = len(nums) - k

        for num in nums:
            while to_pop and stack and stack[-1] > num:
                stack.pop()
                to_pop -= 1
            stack.append(num)

        return list(stack)[:k]