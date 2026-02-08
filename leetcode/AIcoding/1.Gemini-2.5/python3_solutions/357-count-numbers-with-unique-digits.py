class Solution:
    def countNumbersWithUniqueDigits(self, n: int) -> int:
        if n == 0:
            return 1

        # For n=1, numbers are 0, 1, ..., 9. All have unique digits.
        # Count is 10.
        ans = 10 

        # For numbers with k > 1 unique digits:
        # The first digit can be 1-9 (9 choices).
        # The second digit can be any digit except the first (9 choices, including 0).
        # The third digit can be any digit except the first two (8 choices).
        # ...
        # The k-th digit has (10 - (k-1)) choices.

        # current_unique_digits_count represents the number of unique-digit numbers
        # of a specific length (e.g., for 2-digit numbers, it's 9*9=81).
        # We initialize it for the calculation of 2-digit numbers.
        # The first digit has 9 choices (1-9).
        current_unique_digits_count = 9 

        # available_digits represents the number of choices for the next digit.
        # For the second digit, there are 9 choices (0 and 8 other non-zero digits).
        available_digits = 9            

        # Iterate for lengths from 2 up to n
        for i in range(2, n + 1):
            # Calculate the count of unique-digit numbers with 'i' digits
            current_unique_digits_count *= available_digits
            ans += current_unique_digits_count

            # Decrease available choices for the next digit
            available_digits -= 1

            # If no more unique digits can be chosen, break early
            if available_digits == 0:
                break

        return ans