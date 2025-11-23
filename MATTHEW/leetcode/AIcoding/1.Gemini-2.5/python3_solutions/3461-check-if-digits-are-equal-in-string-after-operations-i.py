class Solution:
    def checkDigits(self, s: str) -> bool:
        # According to the problem description, digits are located at even indices.
        # The specified operations only modify characters at odd indices (letters).
        # This means the digits themselves (at even indices) remain unchanged throughout the operations.
        # Therefore, the problem simplifies to checking if all digits in the original string `s` are equal.

        # The problem statement implies s has even length n, and n >= 2 for meaningful operations/digits.
        # If s is empty or has only one digit (e.g., n=2, s="d1"), it's vacuously true or trivially true.
        # We can safely assume s[0] exists and is a digit.

        first_digit = s[0]

        # Iterate through the string, checking only characters at even indices (which are digits).
        # Start from index 2 because index 0 is already stored as first_digit.
        # Increment by 2 to visit only even indices.
        for i in range(2, len(s), 2):
            if s[i] != first_digit:
                return False  # Found a digit that is not equal to the first digit

        # If the loop completes, all digits are equal to the first digit.
        return True