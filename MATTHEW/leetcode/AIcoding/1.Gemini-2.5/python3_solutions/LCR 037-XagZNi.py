class Solution:
    def asteroidCollision(self, asteroids: list[int]) -> list[int]:
        stack = []
        for asteroid in asteroids:
            if asteroid > 0:
                stack.append(asteroid)
            else:
                # current asteroid is negative
                # while stack is not empty, top is positive, and top is smaller than current (abs)
                while stack and stack[-1] > 0 and stack[-1] < abs(asteroid):
                    stack.pop()

                if not stack or stack[-1] < 0:
                    # stack is empty, or top is also negative (moving left)
                    stack.append(asteroid)
                elif stack[-1] == abs(asteroid):
                    # both explode
                    stack.pop()
                # else (stack[-1] > abs(asteroid)): current negative asteroid explodes, do nothing

        return stack