import collections

class Solution:
    def minimumAbsoluteDifference(self, grid: list[list[int]], k: int) -> list[list[int]]:
        m, n = len(grid), len(grid[0])

        # Dimensions of the result matrix
        res_rows = m - k + 1
        res_cols = n - k + 1
        result = [[0] * res_cols for _ in range(res_rows)]

        # Helper function to calculate the minimum absolute difference
        # from a frequency array of values (1 to 100).
        def calculate_min_diff(freq_array):
            min_d = float('inf')
            last_seen_val = -1 # Sentinel value, as grid values are 1 to 100

            # Iterate through all possible values (1 to 100)
            for val in range(1, 101):
                if freq_array[val] > 0: # If the value is present in the current submatrix
                    if last_seen_val != -1: # If there was a previously seen value
                        min_d = min(min_d, val - last_seen_val)
                    last_seen_val = val
            return min_d

        # Iterate through each possible starting row 'r' for the k x k submatrix
        for r in range(res_rows):
            # current_window_freq stores the frequency of each number (1-100)
            # within the current k x k submatrix.
            current_window_freq = [0] * 101 

            # column_freqs stores frequency arrays for each of the 'k' columns
            # currently within the k x k window. column_freqs[j] is the frequency
            # array for the (j+c)-th column of the grid, within rows [r, r+k-1].
            column_freqs = [] 

            # Initialize the first k x k submatrix for the current row 'r'
            # (top-left corner at (r, 0)).
            for j in range(k): # Iterate through the first 'k' columns of the grid
                col_freq = [0] * 101 # Frequency array for the current column
                for i in range(r, r + k): # Iterate through rows within the k-height strip
                    val = grid[i][j]
                    col_freq[val] += 1
                    current_window_freq[val] += 1
                column_freqs.append(col_freq)

            # Calculate and store the minimum absolute difference for the first submatrix
            result[r][0] = calculate_min_diff(current_window_freq)

            # Slide the k x k window horizontally across the current row 'r'
            for c in range(1, res_cols):
                # Remove the leftmost column from the window
                old_col_freq = column_freqs.pop(0)
                for val in range(1, 101):
                    current_window_freq[val] -= old_col_freq[val]

                # Add the new rightmost column to the window
                new_col_freq = [0] * 101
                for i in range(r, r + k):
                    val = grid[i][c + k - 1] # Element from the new column
                    new_col_freq[val] += 1
                    current_window_freq[val] += 1
                column_freqs.append(new_col_freq)

                # Calculate and store the minimum absolute difference for the current submatrix
                result[r][c] = calculate_min_diff(current_window_freq)

        return result