from typing import List

class Solution:
    def largestRectangleArea(self, heights: List[int]) -> int:
        max_area = 0
        stack = [] # Stores indices of bars in increasing order of height

        # Add a sentinel 0 at the beginning and end to handle edge cases
        # This ensures all bars are eventually processed and popped from the stack
        heights_padded = [0] + heights + [0]

        for i in range(len(heights_padded)):
            # While the current bar is shorter than the bar at the top of the stack,
            # it means the bar at stack.top() can extend no further to the right.
            # We can calculate the area for the bar at stack.top().
            while stack and heights_padded[i] < heights_padded[stack[-1]]:
                h_idx = stack.pop()
                h = heights_padded[h_idx]

                # The width is from the bar to the left of the popped bar (stack[-1])
                # up to the current bar (i), excluding i itself.
                # So, width = i - 1 - (stack[-1] + 1) + 1 = i - stack[-1] - 1
                width = i - stack[-1] - 1 
                max_area = max(max_area, h * width)

            # Push the current bar's index onto the stack
            stack.append(i)

        return max_area