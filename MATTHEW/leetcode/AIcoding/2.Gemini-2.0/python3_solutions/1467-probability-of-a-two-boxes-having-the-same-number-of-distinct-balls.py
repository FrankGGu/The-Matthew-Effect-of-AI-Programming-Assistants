from math import comb

class Solution:
    def getProbability(self, balls: list[int]) -> float:
        total_balls = sum(balls)
        half_balls = total_balls // 2

        def count_favorable_outcomes(index, box1_balls, box1_distinct, box2_balls, box2_distinct, current_balls):
            if index == len(balls):
                if box1_balls == half_balls and box1_distinct == box2_distinct:
                    return 1
                else:
                    return 0

            count = 0
            for i in range(min(balls[index], half_balls - box1_balls) + 1):
                new_box1_balls = box1_balls + i
                new_box2_balls = box2_balls + (balls[index] - i)

                new_box1_distinct = box1_distinct + (1 if i > 0 else 0)
                new_box2_distinct = box2_distinct + (1 if balls[index] - i > 0 else 0)

                current_balls *= comb(balls[index], i)

                count += count_favorable_outcomes(index + 1, new_box1_balls, new_box1_distinct, new_box2_balls, new_box2_distinct, current_balls)

                current_balls /= comb(balls[index], i) 

            return count

        def count_total_outcomes(index, box1_balls, current_balls):
            if index == len(balls):
                if box1_balls == half_balls:
                    return 1
                else:
                    return 0

            count = 0
            for i in range(min(balls[index], half_balls - box1_balls) + 1):
                new_box1_balls = box1_balls + i

                current_balls *= comb(balls[index], i)

                count += count_total_outcomes(index + 1, new_box1_balls, current_balls)

                current_balls /= comb(balls[index], i)

            return count

        favorable_outcomes = count_favorable_outcomes(0, 0, 0, 0, 0, 1)
        total_outcomes = count_total_outcomes(0, 0, 1)

        return favorable_outcomes / total_outcomes