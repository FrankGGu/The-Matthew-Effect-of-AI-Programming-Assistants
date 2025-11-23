class Solution:
    def robotCollisions(self, positions: list[int], healths: list[int], directions: str) -> list[int]:
        n = len(positions)
        robots_info = []
        for i in range(n):
            # Store (position, health, direction, original_index)
            robots_info.append([positions[i], healths[i], directions[i], i])

        # Sort robots by their position to process them from left to right
        robots_info.sort()

        stack = [] # Stores (original_index, health, direction) of robots that are currently moving right or have survived collisions

        for pos, health, direction, original_index in robots_info:
            if direction == 'R':
                stack.append([original_index, health, direction])
            else: # direction == 'L'
                current_l_health = health
                current_l_original_index = original_index

                l_robot_destroyed = False

                # Process collisions with robots moving 'R' from the stack
                while stack and stack[-1][2] == 'R':
                    r_original_index, r_health, r_direction = stack.pop()

                    if current_l_health > r_health:
                        current_l_health -= 1
                        # R robot is destroyed, L robot continues with reduced health
                    elif current_l_health < r_health:
                        r_health -= 1
                        stack.append([r_original_index, r_health, r_direction]) # R robot survives, push back
                        l_robot_destroyed = True
                        break # L robot is destroyed
                    else: # current_l_health == r_health
                        # Both robots are destroyed
                        l_robot_destroyed = True
                        break

                # If the 'L' robot survived all collisions (or there were no 'R' robots to collide with)
                if not l_robot_destroyed:
                    stack.append([current_l_original_index, current_l_health, direction])

        # Collect final healths, sorted by their original indices
        final_survivors = []
        for original_index, health, _ in stack:
            final_survivors.append([original_index, health])

        # Sort by original_index to get the result in the specified order
        final_survivors.sort()

        result_healths = [health for _, health in final_survivors]

        return result_healths