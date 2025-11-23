class Solution:
    def robotSim(self, commands: list[int], obstacles: list[list[int]]) -> int:

        # Directions: 0: North, 1: East, 2: South, 3: West
        # dx, dy represent change in x and y for each direction
        dx = [0, 1, 0, -1]
        dy = [1, 0, -1, 0]

        # Robot's initial position and direction
        x, y = 0, 0
        current_direction = 0 # Starts facing North

        # Store obstacles in a set for O(1) lookup
        obstacle_set = set(tuple(o) for o in obstacles)

        max_squared_distance = 0

        for command in commands:
            if command == -2:  # Turn left 90 degrees
                current_direction = (current_direction - 1 + 4) % 4
            elif command == -1: # Turn right 90 degrees
                current_direction = (current_direction + 1) % 4
            else: # Move forward 'command' steps
                for _ in range(command):
                    next_x = x + dx[current_direction]
                    next_y = y + dy[current_direction]

                    if (next_x, next_y) in obstacle_set:
                        # If next step is an obstacle, robot stops moving in this direction
                        break
                    else:
                        # Move to the next position
                        x, y = next_x, next_y

                # Update maximum squared Euclidean distance
                max_squared_distance = max(max_squared_distance, x*x + y*y)

        return max_squared_distance