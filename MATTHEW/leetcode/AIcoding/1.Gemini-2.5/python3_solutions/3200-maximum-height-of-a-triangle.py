class Solution:
    def maxHeightOfTriangle(self, red: int, blue: int) -> int:

        def calculate_height(balls1: int, balls2: int) -> int:
            height = 0
            current_row_balls_needed = 1

            temp_balls1 = balls1
            temp_balls2 = balls2

            while True:
                if current_row_balls_needed % 2 == 1:
                    if temp_balls1 >= current_row_balls_needed:
                        temp_balls1 -= current_row_balls_needed
                        height += 1
                    else:
                        break
                else:
                    if temp_balls2 >= current_row_balls_needed:
                        temp_balls2 -= current_row_balls_needed
                        height += 1
                    else:
                        break

                current_row_balls_needed += 1

            return height

        height1 = calculate_height(red, blue)
        height2 = calculate_height(blue, red)

        return max(height1, height2)