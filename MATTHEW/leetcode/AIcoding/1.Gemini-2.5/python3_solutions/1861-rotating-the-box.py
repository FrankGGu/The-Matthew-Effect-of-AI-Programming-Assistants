class Solution:
    def rotateTheBox(self, box: list[list[str]]) -> list[list[str]]:
        R = len(box)
        C = len(box[0])

        new_R = C
        new_C = R

        rotated_box = [['.' for _ in range(new_C)] for _ in range(new_R)]

        # Step 1: Rotate the box 90 degrees clockwise
        for r in range(R):
            for c in range(C):
                rotated_box[c][R - 1 - r] = box[r][c]

        # Step 2: Apply gravity
        # In the rotated box, gravity means stones fall towards increasing column index (to the right)
        for r_new in range(new_R):  # Iterate through each row of the new box
            land_position = new_C - 1  # Start from the rightmost column in the current row
            for c_new in range(new_C - 1, -1, -1):  # Iterate from right to left in the current row
                if rotated_box[r_new][c_new] == '#':
                    # If it's a stone, move it to the current land_position
                    rotated_box[r_new][land_position] = '#'
                    if land_position != c_new:
                        rotated_box[r_new][c_new] = '.'
                    land_position -= 1  # The next stone will land one spot to the left
                elif rotated_box[r_new][c_new] == '*':
                    # If it's an obstacle, it stops stones above it.
                    # The next land_position will be just to its left.
                    land_position = c_new - 1
                # If it's '.', do nothing, as it's an empty spot that can be filled later

        return rotated_box