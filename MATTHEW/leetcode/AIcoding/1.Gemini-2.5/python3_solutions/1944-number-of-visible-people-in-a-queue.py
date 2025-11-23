from typing import List

class Solution:
    def canSeePersonsCount(self, heights: List[int]) -> List[int]:
        n = len(heights)
        ans = [0] * n
        stack = [] # Stores indices of people, maintaining a strictly decreasing sequence of heights

        # Iterate from right to left
        for i in range(n - 1, -1, -1):
            count = 0
            # Pop people from the stack who are shorter than the current person (heights[i])
            # These popped people are visible to heights[i]
            while stack and heights[stack[-1]] < heights[i]:
                count += 1
                stack.pop()

            # If the stack is not empty after popping, the person at the top of the stack
            # is taller than heights[i]. This person is also visible to heights[i].
            # This person will block the view to any subsequent (shorter) people behind them.
            if stack:
                count += 1

            ans[i] = count

            # Push the current person's index onto the stack.
            # Since all people shorter than heights[i] have been popped,
            # heights[i] will either be the only element or be shorter than the current top.
            # This maintains the strictly decreasing order of heights in the stack.
            stack.append(i)

        return ans