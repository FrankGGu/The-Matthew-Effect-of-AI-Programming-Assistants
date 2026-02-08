class Solution:
    def largestRectangleArea(self, heights: list[int]) -> int:
        max_area = 0
        stack = []  # Stores indices of bars in increasing order of height

        # Append a 0 to ensure all bars in the stack are processed
        # This acts as a sentinel to pop all remaining elements
        heights.append(0) 

        for i, h in enumerate(heights):
            # While the stack is not empty and the current height is less than
            # the height of the bar at the top of the stack
            while stack and heights[stack[-1]] > h:
                # Pop the index of the bar that is taller than the current bar
                height_idx = stack.pop()
                current_height = heights[height_idx]

                # Calculate the width of the rectangle with current_height
                # If stack is empty, it means current_height is the smallest so far,
                # and its width extends from index 0 to i-1.
                # Otherwise, the width extends from the index of the previous smaller bar (stack[-1]) + 1 to i-1.
                width = i if not stack else i - stack[-1] - 1

                max_area = max(max_area, current_height * width)

            # Push the current index onto the stack
            stack.append(i)

        return max_area