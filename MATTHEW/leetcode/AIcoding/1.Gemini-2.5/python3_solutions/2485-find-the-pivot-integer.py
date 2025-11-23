import math

class Solution:
    def pivotInteger(self, n: int) -> int:

        # The problem asks for an integer x such that the sum of integers from 1 to x
        # is equal to the sum of integers from x to n.
        # Let S_left = 1 + 2 + ... + x = x * (x + 1) / 2
        # Let S_right = x + (x + 1) + ... + n
        # We can express S_right as (1 + 2 + ... + n) - (1 + 2 + ... + x - 1)
        # S_right = n * (n + 1) / 2 - (x - 1) * x / 2

        # The condition is S_left = S_right:
        # x * (x + 1) / 2 = n * (n + 1) / 2 - (x - 1) * x / 2

        # Multiply by 2 to clear denominators:
        # x * (x + 1) = n * (n + 1) - (x - 1) * x

        # Expand terms:
        # x^2 + x = n^2 + n - (x^2 - x)
        # x^2 + x = n^2 + n - x^2 + x

        # Simplify by cancelling 'x' on both sides and moving 'x^2' terms:
        # x^2 = n^2 + n - x^2
        # 2 * x^2 = n^2 + n
        # 2 * x^2 = n * (n + 1)
        # x^2 = n * (n + 1) / 2

        # So, we need to find an integer x such that its square is equal to n * (n + 1) / 2.
        # If n * (n + 1) / 2 is a perfect square, then its integer square root is the pivot integer.
        # Otherwise, no such integer exists.

        target_square_value = n * (n + 1) // 2

        # Calculate the integer square root of the target value.
        # Using math.isqrt for integer square root or int(math.sqrt())
        x_candidate = int(math.sqrt(target_square_value))

        # Check if the square of the candidate is exactly the target value.
        # This verifies if target_square_value was a perfect square.
        if x_candidate * x_candidate == target_square_value:
            return x_candidate
        else:
            return -1