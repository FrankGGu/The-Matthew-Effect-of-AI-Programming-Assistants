class Solution:
    def spiralMatrixIII(self, rows: int, cols: int, rStart: int, cStart: int) -> list[list[int]]:
        result = []

        # Directions: East, South, West, North
        # dr: change in row, dc: change in col
        dr = [0, 1, 0, -1]
        dc = [1, 0, -1, 0]

        curr_r, curr_c = rStart, cStart

        # Keep track of visited cells to avoid duplicates and ensure we stop when all unique cells are found
        visited = set()

        # Add the starting cell
        result.append([curr_r, curr_c])
        visited.add((curr_r, curr_c))

        # dir_idx: current direction index (0: East, 1: South, 2: West, 3: North)
        dir_idx = 0

        # steps_to_take: number of steps to take in the current segment
        steps_to_take = 1

        # segments_taken_for_current_steps: counts how many times we've taken `steps_to_take` steps.
        # It will be 0 or 1. When it becomes 2, we increment steps_to_take and reset it.
        segments_taken_for_current_steps = 0

        # Loop until all unique cells are visited
        while len(result) < rows * cols:
            # Take steps_to_take steps in the current direction
            for _ in range(steps_to_take):
                curr_r += dr[dir_idx]
                curr_c += dc[dir_idx]

                # Check if the current cell is within bounds and not yet visited
                if 0 <= curr_r < rows and 0 <= curr_c < cols and (curr_r, curr_c) not in visited:
                    result.append([curr_r, curr_c])
                    visited.add((curr_r, curr_c))

                # If all cells are visited, stop
                if len(result) == rows * cols:
                    break

            # If all cells are visited, stop the outer loop as well
            if len(result) == rows * cols:
                break

            # Turn right (change direction)
            dir_idx = (dir_idx + 1) % 4

            # Increment the count of segments taken for the current steps_to_take
            segments_taken_for_current_steps += 1

            # If two segments of the same length have been taken, increment steps_to_take
            if segments_taken_for_current_steps == 2:
                steps_to_take += 1
                segments_taken_for_current_steps = 0 # Reset for the new steps_to_take

        return result