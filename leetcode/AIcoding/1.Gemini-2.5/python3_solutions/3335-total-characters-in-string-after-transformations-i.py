class Solution:
    def getLucky(self, s: str, k: int) -> int:
        # Step 1: Convert the string s into its initial number string.
        # Each character is replaced by its 1-indexed alphabetical position.
        # For example, 'a' -> 1, 'b' -> 2, ..., 'z' -> 26.
        initial_num_str_parts = []
        for char_code in s:
            # Calculate 1-indexed position: ord(char) - ord('a') + 1
            initial_num_str_parts.append(str(ord(char_code) - ord('a') + 1))

        # Join the parts to form the complete initial number string.
        current_num_str = "".join(initial_num_str_parts)

        # Step 2: Perform k transformations.
        # Each transformation involves summing the digits of the current number string.
        # The result of the sum then becomes the new number string for the next transformation.
        for _ in range(k):
            current_sum = 0
            # Sum the digits of the current number string.
            for digit_char in current_num_str:
                current_sum += int(digit_char)

            # Convert the sum back to a string for the next iteration.
            # This also prepares the final result as a string before the last int conversion.
            current_num_str = str(current_sum)

        # After k transformations, current_num_str holds the string representation
        # of the final sum. Convert it to an integer and return.
        return int(current_num_str)