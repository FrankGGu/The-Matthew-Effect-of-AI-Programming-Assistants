class Solution:
    def decodeCiphertext(self, encodedText: str, rows: int) -> str:
        n_e = len(encodedText)

        if n_e == 0:
            return ""

        # Determine the number of columns in the grid.
        # The characters in encodedText are read diagonally.
        # Specifically, the characters are taken from diagonals starting at (0, k) for k = 0, 1, ..., cols-1.
        # Within each diagonal, characters are read from row 0, then row 1, and so on.
        # So, encodedText[i] corresponds to grid[r][c] where:
        # r = i % rows (row index within the diagonal)
        # c = (i // rows) + r (column index)
        # The maximum column index reached by any character in encodedText determines the number of columns.
        # For i = n_e - 1 (the last character):
        # max_r_in_diag = (n_e - 1) % rows
        # max_diag_idx = (n_e - 1) // rows
        # max_c = max_diag_idx + max_r_in_diag
        # The total number of columns is max_c + 1.

        # Calculate the maximum column index reached by any character in encodedText.
        # If n_e is 0, this calculation would be on -1, so handle that case.
        max_c_idx = ((n_e - 1) // rows) + ((n_e - 1) % rows)
        cols = max_c_idx + 1

        # Initialize the grid with spaces
        grid = [[' '] * cols for _ in range(rows)]

        # Fill the grid using the diagonal reading pattern
        encoded_idx = 0
        for diag_idx in range(cols):  # Iterate through diagonals (starting column k)
            for r in range(rows):  # Iterate through rows within the diagonal
                c = diag_idx + r  # Calculate column index for the current character

                # Check if the current cell (r, c) is within grid bounds
                if c < cols:
                    # Check if there are still characters left in encodedText
                    if encoded_idx < n_e:
                        grid[r][c] = encodedText[encoded_idx]
                        encoded_idx += 1
                    else:
                        # No more characters in encodedText, stop filling
                        break
                else:
                    # Column out of bounds for this diagonal, move to next diagonal
                    break

            # If all characters from encodedText have been placed, we can stop
            if encoded_idx == n_e:
                break

        # Read the originalText from the grid row by row
        original_text_chars = []
        for r in range(rows):
            for c in range(cols):
                original_text_chars.append(grid[r][c])

        # Join characters and remove any trailing spaces from the final string
        return "".join(original_text_chars).rstrip()