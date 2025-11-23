import math

class Solution:
    def judgePoint24(self, cards: list[int]) -> bool:
        EPSILON = 1e-6

        # Convert integers to floats for division
        nums = [float(card) for card in cards]

        def solve(current_nums: list[float]) -> bool:
            # Base case 1: If no numbers are left, it's not possible to reach 24.
            if len(current_nums) == 0:
                return False
            # Base case 2: If only one number is left, check if it's approximately 24.
            if len(current_nums) == 1:
                return abs(current_nums[0] - 24) < EPSILON

            n = len(current_nums)
            # Iterate through all unique pairs of numbers
            for i in range(n):
                for j in range(n):
                    if i == j:
                        continue

                    # Create a new list without current_nums[i] and current_nums[j]
                    next_nums = []
                    for k in range(n):
                        if k != i and k != j:
                            next_nums.append(current_nums[k])

                    a, b = current_nums[i], current_nums[j]

                    # Try all 6 possible operations
                    # 1. Addition
                    if solve(next_nums + [a + b]):
                        return True
                    # 2. Subtraction (a - b)
                    if solve(next_nums + [a - b]):
                        return True
                    # 3. Multiplication
                    if solve(next_nums + [a * b]):
                        return True
                    # 4. Division (a / b) - avoid division by zero
                    if abs(b) > EPSILON:
                        if solve(next_nums + [a / b]):
                            return True

            # If no combination of operations leads to 24, return False
            return False

        return solve(nums)