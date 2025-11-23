class Solution:
    def findNthDigit(self, n: int) -> int:
        digits_count = 1
        numbers_in_block = 9
        first_num_in_block = 1

        while n > digits_count * numbers_in_block:
            n -= digits_count * numbers_in_block
            digits_count += 1
            numbers_in_block *= 10
            first_num_in_block *= 10

        # Now, n is the 1-indexed position within the current block of numbers.
        # digits_count is the number of digits each number in this block has.
        # first_num_in_block is the first number in this block (e.g., 1, 10, 100, ...).

        # Calculate which number contains the nth digit
        # (n - 1) because we want 0-indexed for division/modulo
        target_number_index = (n - 1) // digits_count
        target_number = first_num_in_block + target_number_index

        # Calculate which digit within that number is the nth digit
        digit_index_in_target_number = (n - 1) % digits_count

        # Convert the target number to a string to extract the digit
        return int(str(target_number)[digit_index_in_target_number])