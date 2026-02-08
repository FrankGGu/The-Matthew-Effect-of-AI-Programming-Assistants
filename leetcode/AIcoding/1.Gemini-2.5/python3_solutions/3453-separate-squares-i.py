import math

class Solution:
    def separateSquares(self, nums: list[int]) -> list[list[int]]:
        perfect_squares = []
        non_perfect_squares = []

        for num in nums:
            if num < 0:
                non_perfect_squares.append(num)
            else:
                sqrt_num = int(math.sqrt(num))
                if sqrt_num * sqrt_num == num:
                    perfect_squares.append(num)
                else:
                    non_perfect_squares.append(num)

        return [perfect_squares, non_perfect_squares]