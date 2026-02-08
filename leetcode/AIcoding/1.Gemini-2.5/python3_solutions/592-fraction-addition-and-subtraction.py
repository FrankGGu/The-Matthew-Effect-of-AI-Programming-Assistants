import math

class Solution:
    def fractionAddition(self, expression: str) -> str:

        # Helper function to compute the greatest common divisor
        def gcd(a, b):
            return math.gcd(a, b)

        # Initialize the total sum as 0/1
        total_num = 0
        total_den = 1

        i = 0
        n = len(expression)

        while i < n:
            # Determine the sign of the current fraction
            sign = 1
            if expression[i] == '-':
                sign = -1
                i += 1
            elif expression[i] == '+':
                i += 1

            # Parse the numerator
            num_start = i
            while i < n and expression[i].isdigit():
                i += 1
            current_num = int(expression[num_start:i])

            # Skip the '/' character
            i += 1 

            # Parse the denominator
            den_start = i
            while i < n and expression[i].isdigit():
                i += 1
            current_den = int(expression[den_start:i])

            # Apply the sign to the numerator
            current_num *= sign

            # Add the current fraction to the total sum
            # (a/b) + (c/d) = (ad + bc) / bd
            new_total_num = total_num * current_den + current_num * total_den
            new_total_den = total_den * current_den

            # Update the total sum
            total_num = new_total_num
            total_den = new_total_den

            # Simplify the total fraction by dividing by their GCD
            # This helps prevent intermediate numbers from becoming too large
            common_divisor = gcd(abs(total_num), abs(total_den))
            total_num //= common_divisor
            total_den //= common_divisor

        # If the numerator is 0, the result should be "0/1"
        if total_num == 0:
            return "0/1"

        return str(total_num) + "/" + str(total_den)