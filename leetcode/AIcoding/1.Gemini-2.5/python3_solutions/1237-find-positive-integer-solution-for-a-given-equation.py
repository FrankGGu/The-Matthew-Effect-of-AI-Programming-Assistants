"""
This is the custom function interface.
You should not implement it, or speculate about its implementation
"""
class CustomFunction:
    # Returns f(x, y) for any given positive integers x and y.
    # Note that f(x, y) is increasing with respect to both x and y.
    # i.e. f(x, y) < f(x + 1, y), f(x, y) < f(x, y + 1)
    def f(self, x: int, y: int) -> int:
        pass

class Solution:
    def findSolution(self, customfunction: 'CustomFunction', z: int) -> list[list[int]]:
        solutions = []

        # Initialize x from 1 and y from the maximum possible value (1000, as per constraints).
        # The search space for x and y is 1 to 1000.
        x = 1
        y = 1000

        # Use a two-pointer approach.
        # x increases from 1, y decreases from 1000.
        # This works because customfunction.f(x, y) is strictly increasing in both x and y.
        while x <= 1000 and y >= 1:
            val = customfunction.f(x, y)

            if val == z:
                # Found a solution. Add it to the list.
                solutions.append([x, y])
                # To find other solutions, we need to move both pointers.
                # Increment x to look for solutions with a larger x.
                # Decrement y because if x increased, y must decrease to potentially find the same z.
                x += 1
                y -= 1
            elif val < z:
                # The current value is too small. To get a larger value, we must increase x.
                # Increasing y would also increase the value, but we are trying to find solutions
                # efficiently by moving x and y towards each other. If we increase y, we might
                # miss solutions for the current x. By increasing x, we are systematically
                # exploring the search space.
                x += 1
            else: # val > z
                # The current value is too large. To get a smaller value, we must decrease y.
                y -= 1

        return solutions