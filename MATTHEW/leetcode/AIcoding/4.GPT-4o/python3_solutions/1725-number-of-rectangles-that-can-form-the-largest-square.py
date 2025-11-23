class Solution:
    def countGoodRectangles(self, rectangles: List[List[int]]) -> int:
        max_square_length = 0
        count = 0

        for length, width in rectangles:
            square_length = min(length, width)
            if square_length > max_square_length:
                max_square_length = square_length
                count = 1
            elif square_length == max_square_length:
                count += 1

        return count