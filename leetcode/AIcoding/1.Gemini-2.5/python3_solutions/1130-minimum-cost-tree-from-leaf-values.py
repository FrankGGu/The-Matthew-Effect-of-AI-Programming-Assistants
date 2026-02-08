import math

class Solution:
    def mctFromLeafValues(self, arr: list[int]) -> int:
        res = 0
        stack = [math.inf]

        for a in arr:
            while stack[-1] <= a:
                mid = stack.pop()
                res += mid * min(stack[-1], a)
            stack.append(a)

        while len(stack) > 2:
            res += stack.pop() * stack[-1]

        return res