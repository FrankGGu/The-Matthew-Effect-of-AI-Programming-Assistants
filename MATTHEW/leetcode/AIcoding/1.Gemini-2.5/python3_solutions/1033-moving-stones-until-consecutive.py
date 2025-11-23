from typing import List

class Solution:
    def numMovesStones(self, a: int, b: int, c: int) -> List[int]:
        nums = sorted([a, b, c])
        x, y, z = nums[0], nums[1], nums[2]

        min_moves = 0
        if z - x == 2:
            # Stones are already consecutive (e.g., 1, 2, 3)
            min_moves = 0
        elif (y - x == 1 and z - y >= 2) or \
             (z - y == 1 and y - x >= 2) or \
             (y - x == 2) or \
             (z - y == 2):
            # One move is sufficient if:
            # - Two stones are adjacent (gap of 1) and the third is not (e.g., 1, 2, 5 or 1, 4, 5)
            # - One gap is 2 (e.g., 1, 3, 4 or 1, 2, 4)
            # This covers cases like [1,2,4], [1,2,5], [1,3,4], [1,4,5]
            # The condition `y - x == 2` or `z - y == 2` is actually sufficient for all these cases,
            # provided they are not already consecutive.
            # Let's simplify the min_moves logic as derived in thought process:
            # 0 moves if already consecutive (z - x == 2)
            # 1 move if one of the gaps is 1 AND the other gap is >= 2 (e.g. [1,2,5] or [1,4,5])
            # OR if one of the gaps is 2 AND the other gap is >= 1 (e.g. [1,3,4] or [1,2,4])
            # All other cases are 2 moves.

            # The most robust logic for min_moves:
            # 0 moves if z - x == 2 (e.g., [1,2,3])
            # 1 move if (y - x == 1 and z - y >= 2) or (z - y == 1 and y - x >= 2)
            # This covers cases where one of the outer stones can be moved next to the other two to form a consecutive triplet.
            # e.g., [1,2,5] -> move 5 to 3. [1,4,5] -> move 1 to 3.
            # e.g., [1,2,4] -> move 4 to 3. [1,3,4] -> move 1 to 2.
            # All other scenarios (where neither of the above is true) require 2 moves.
            # e.g., [1,3,5], [1,3,6], [1,4,6], [1,5,10]

            # Let's use the simplified and correct logic:
            # If z - x == 2, min_moves = 0
            # Else if (y - x == 1 and z - y >= 2) or (z - y == 1 and y - x >= 2), min_moves = 1
            # Else, min_moves = 2

            # Applying this logic:
            if (y - x == 1 and z - y >= 2) or \
               (z - y == 1 and y - x >= 2):
                min_moves = 1
            else:
                min_moves = 2

        # Maximum moves:
        # The total number of empty slots between the smallest and largest stone is (z - x - 2).
        # Each move can fill one empty slot.
        # So, the maximum number of moves is the total number of empty slots.
        # This is equivalent to (y - x - 1) + (z - y - 1).
        max_moves = (y - x - 1) + (z - y - 1)

        return [min_moves, max_moves]