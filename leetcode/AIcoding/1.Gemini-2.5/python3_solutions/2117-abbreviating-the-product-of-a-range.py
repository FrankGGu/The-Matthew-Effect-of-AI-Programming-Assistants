import math

class Solution:
    def abbreviateProduct(self, left: int, right: int) -> str:
        # Constants for calculations
        MAX_DIGITS_FOR_FULL_PRODUCT = 10
        MOD_FOR_LAST_DIGITS = 10**5 # We need the last 5 digits, so modulo 10^5 is sufficient.
        FIRST_PART_PRECISION_THRESHOLD = 10**6 # Keep first_part_product_float below this to maintain precision

        # Variables to track
        total_digits_sum_log10 = 0.0
        first_part_product_float = 1.0
        last_part_product_int = 1

        # Iterate through the range to calculate components
        for i in range(left, right + 1):
            total_digits_sum_log10 += math.log10(i)

            first_part_product_float *= i
            # Keep first_part_product_float in a manageable range (e.g., < 10^6)
            # This effectively keeps track of the most significant digits.
            while first_part_product_float >= FIRST_PART_PRECISION_THRESHOLD:
                first_part_product_float /= 10

            # Calculate the product modulo 10^5 to get the last 5 digits.
            # Python's arbitrary precision integers handle this without overflow.
            last_part_product_int = (last_part_product_int * i) % MOD_FOR_LAST_DIGITS

        # Calculate total number of digits in the product
        total_digits_count = math.floor(total_digits_sum_log10) + 1

        # Case 1: Product has 10 or fewer digits
        if total_digits_count <= MAX_DIGITS_FOR_FULL_PRODUCT:
            actual_product = 1
            for i in range(left, right + 1):
                actual_product *= i
            return str(actual_product)

        # Case 2: Product has more than 10 digits
        else:
            # Calculate first 5 digits
            # first_part_product_float is approximately P / 10^k for some k.
            # To get the first 5 digits, we need to scale first_part_product_float
            # so that its first digit is in the highest place value, then take 5 digits.
            # The scaling factor depends on the current number of digits in first_part_product_float.
            digits_in_first_part_float = math.floor(math.log10(first_part_product_float)) + 1
            first5_str = str(int(first_part_product_float * (10**(5 - digits_in_first_part_float))))[:5]

            # Calculate last 5 digits
            # last_part_product_int already holds P % 10^5.
            # We need to pad with leading zeros if it has fewer than 5 digits.
            last5_str = str(last_part_product_int).zfill(5)

            return f"{first5_str}...{last5_str}e{total_digits_count}"