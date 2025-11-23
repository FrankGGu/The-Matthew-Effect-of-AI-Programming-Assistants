class Solution:
    def substringXorQueries(self, s: str, queries: list[list[int]]) -> list[list[int]]:
        n = len(s)
        val_to_coords = {}

        # Max value for x is first ^ second.
        # Given first, second <= 10^9.
        # 10^9 is less than 2^30 (1073741824).
        # So, x will always be less than 2^30.
        # This means the binary representation of x will have at most 30 bits.
        # For example, 2^30 - 1 is a 30-bit number (30 ones).
        # We only need to consider substrings that represent values less than 2^30.

        MAX_LEN_TO_CONSIDER = 30 
        MAX_X_VALUE = 1 << MAX_LEN_TO_CONSIDER # This is 2^30

        for i in range(n):
            current_val = 0
            # Iterate j to form substrings s[i...j]
            # The length of substring s[i...j] is j - i + 1.
            # We want to check substrings of length up to MAX_LEN_TO_CONSIDER.
            # So j - i + 1 <= MAX_LEN_TO_CONSIDER
            # This means j <= i + MAX_LEN_TO_CONSIDER - 1.
            # The range for j should be from i up to i + MAX_LEN_TO_CONSIDER - 1.
            # So range(i, i + MAX_LEN_TO_CONSIDER) for j is correct.
            for j in range(i, min(n, i + MAX_LEN_TO_CONSIDER)):
                digit = int(s[j])

                # If current_val is already too large, any further multiplication/addition
                # will only make it larger, so we can break.
                # We are interested in values strictly less than MAX_X_VALUE.
                if current_val >= MAX_X_VALUE:
                    break

                current_val = current_val * 2 + digit

                # After updating, if current_val is still within limits, store it.
                # Values like 0 are valid.
                if current_val < MAX_X_VALUE:
                    if current_val not in val_to_coords:
                        val_to_coords[current_val] = [i, j]
                    else:
                        # If current_val is already in map, check for smaller i, then smaller j
                        existing_i, existing_j = val_to_coords[current_val]
                        if i < existing_i:
                            val_to_coords[current_val] = [i, j]
                        elif i == existing_i and j < existing_j:
                            val_to_coords[current_val] = [i, j]

        results = []
        for first, second in queries:
            x = first ^ second
            if x in val_to_coords:
                results.append(val_to_coords[x])
            else:
                results.append([-1, -1])

        return results