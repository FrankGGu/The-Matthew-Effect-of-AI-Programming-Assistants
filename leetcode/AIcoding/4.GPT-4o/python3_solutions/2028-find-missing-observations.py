class Solution:
    def findMissingObservations(self, observations: List[int]) -> List[int]:
        n = len(observations)
        total_sum = (n + 2) * (n + 1) // 2
        current_sum = sum(observations)
        missing_sum = total_sum - current_sum

        # Find the missing number by using the formula for sum of first n natural numbers
        # x + y = missing_sum
        # x * y = totalSumOfSquares - currentSumOfSquares

        total_sum_of_squares = sum(i * i for i in range(1, n + 3))
        current_sum_of_squares = sum(x * x for x in observations)
        missing_sum_of_squares = total_sum_of_squares - current_sum_of_squares

        # Now we have:
        # x + y = missing_sum
        # x^2 + y^2 = missing_sum_of_squares

        # From (x + y)^2 = x^2 + y^2 + 2xy
        # We can derive:
        # xy = (missing_sum^2 - missing_sum_of_squares) // 2

        xy = (missing_sum * missing_sum - missing_sum_of_squares) // 2

        # Now we can solve the equations:
        # x and y are the roots of t^2 - (missing_sum)t + xy = 0
        discriminant = missing_sum * missing_sum - 4 * xy

        x = (missing_sum + int(discriminant**0.5)) // 2
        y = (missing_sum - int(discriminant**0.5)) // 2

        return [x, y]