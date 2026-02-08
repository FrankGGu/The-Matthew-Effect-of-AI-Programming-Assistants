from typing import List

class Solution:
    def numOfBurgers(self, tomatoSlices: int, cheeseSlices: int) -> List[int]:
        # Let j be the number of jumbo burgers and s be the number of small burgers.
        # A jumbo burger requires 4 tomato slices and 1 cheese slice.
        # A small burger requires 2 tomato slices and 1 cheese slice.

        # We can set up a system of two linear equations:
        # 1) 4*j + 2*s = tomatoSlices
        # 2) 1*j + 1*s = cheeseSlices

        # From equation (2), we can express s in terms of j:
        # s = cheeseSlices - j

        # Substitute this expression for s into equation (1):
        # 4*j + 2*(cheeseSlices - j) = tomatoSlices
        # 4*j + 2*cheeseSlices - 2*j = tomatoSlices
        # 2*j + 2*cheeseSlices = tomatoSlices
        # 2*j = tomatoSlices - 2*cheeseSlices
        # j = (tomatoSlices - 2*cheeseSlices) / 2

        # Now substitute j back into s = cheeseSlices - j:
        # s = cheeseSlices - (tomatoSlices - 2*cheeseSlices) / 2
        # s = (2*cheeseSlices - (tomatoSlices - 2*cheeseSlices)) / 2
        # s = (2*cheeseSlices - tomatoSlices + 2*cheeseSlices) / 2
        # s = (4*cheeseSlices - tomatoSlices) / 2

        # For j and s to be valid numbers of burgers, they must satisfy three conditions:
        # 1. j must be a non-negative integer.
        # 2. s must be a non-negative integer.

        # Condition for integer values:
        # Both (tomatoSlices - 2*cheeseSlices) and (4*cheeseSlices - tomatoSlices) must be even.
        # If tomatoSlices is odd, then (tomatoSlices - 2*cheeseSlices) will be odd - even = odd.
        # So, tomatoSlices must be even for j to be an integer.
        # If tomatoSlices is even, then (tomatoSlices - 2*cheeseSlices) is even - even = even.
        # And (4*cheeseSlices - tomatoSlices) is even - even = even.
        # Thus, the sole parity condition is that tomatoSlices must be even.
        if tomatoSlices % 2 != 0:
            return []

        # Condition for non-negative values:
        # j >= 0  => (tomatoSlices - 2*cheeseSlices) / 2 >= 0  => tomatoSlices - 2*cheeseSlices >= 0
        #           => tomatoSlices >= 2*cheeseSlices
        # s >= 0  => (4*cheeseSlices - tomatoSlices) / 2 >= 0  => 4*cheeseSlices - tomatoSlices >= 0
        #           => 4*cheeseSlices >= tomatoSlices

        # Calculate the numerators for j and s
        numerator_j = tomatoSlices - 2 * cheeseSlices
        numerator_s = 4 * cheeseSlices - tomatoSlices

        # Check non-negativity
        if numerator_j < 0 or numerator_s < 0:
            return []

        # If all conditions are met, calculate the number of burgers
        jumbo_burgers = numerator_j // 2
        small_burgers = numerator_s // 2

        return [jumbo_burgers, small_burgers]