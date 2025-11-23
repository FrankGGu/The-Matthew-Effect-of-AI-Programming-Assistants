class Solution:
    def asteroidCollision(self, asteroids: list[int]) -> list[int]:
        stack = []
        for asteroid in asteroids:
            if asteroid > 0:
                stack.append(asteroid)
            else:
                # Current asteroid is moving left (negative)
                # Check for collisions with right-moving asteroids on top of the stack
                while stack and stack[-1] > 0:
                    if abs(asteroid) > stack[-1]:
                        # Current asteroid is larger, destroys the top asteroid
                        stack.pop()
                        # Continue checking with the new top asteroid
                    elif abs(asteroid) == stack[-1]:
                        # Both asteroids are equal, both explode
                        stack.pop()
                        asteroid = 0  # Mark current asteroid as destroyed
                        break
                    else:
                        # Top asteroid is larger, current asteroid explodes
                        asteroid = 0  # Mark current asteroid as destroyed
                        break

                if asteroid != 0:
                    # If the current asteroid survived all collisions (or no right-moving asteroids were encountered)
                    stack.append(asteroid)

        return stack