class Solution:
    def largestRectangleArea(self, heights: list[int]) -> int:
        max_area = 0
        stack = [] # Stores indices of bars in increasing order of height

        for i in range(len(heights)):
            # While the stack is not empty and the current bar is shorter than or equal to the bar at the top of the stack
            # This means the bar at stack.top() cannot extend further to the right than 'i'
            while stack and heights[stack[-1]] >= heights[i]:
                h_idx = stack.pop()
                h = heights[h_idx]
                # Calculate width:
                # If stack is empty, it means the popped bar is the smallest to its left,
                # so it extends from index 0 to i-1. Width is 'i'.
                # Otherwise, the bar at stack[-1] is the first bar to the left that is shorter than h.
                # So, h_idx bar extends from stack[-1] + 1 to i - 1. Width is i - (stack[-1] + 1).
                width = i if not stack else i - stack[-1] - 1
                max_area = max(max_area, h * width)
            stack.append(i)

        # After iterating through all bars, process any remaining bars in the stack
        # These bars extend to the very end of the histogram (index len(heights) - 1)
        n = len(heights)
        while stack:
            h_idx = stack.pop()
            h = heights[h_idx]
            # Calculate width:
            # If stack is empty, the popped bar is the smallest to its left,
            # so it extends from index 0 to n-1. Width is 'n'.
            # Otherwise, the bar at stack[-1] is the first bar to the left that is shorter than h.
            # So, h_idx bar extends from stack[-1] + 1 to n - 1. Width is n - (stack[-1] + 1).
            width = n if not stack else n - stack[-1] - 1
            max_area = max(max_area, h * width)

        return max_area