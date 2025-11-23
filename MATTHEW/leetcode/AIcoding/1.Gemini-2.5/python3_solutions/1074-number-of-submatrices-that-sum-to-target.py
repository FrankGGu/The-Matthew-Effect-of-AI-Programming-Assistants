class Solution:
    def numSubmatrixSumTarget(self, matrix: list[list[int]], target: int) -> int:
        R = len(matrix)
        C = len(matrix[0])

        total_submatrices = 0

        # Iterate over all possible top rows (r1)
        for r1 in range(R):
            # Initialize a 1D array to store column sums for the current submatrix slice
            # This array will accumulate sums from row r1 up to the current row r2
            current_col_sums = [0] * C

            # Iterate over all possible bottom rows (r2) starting from r1
            for r2 in range(r1, R):
                # For the current slice of rows (from r1 to r2), update the current_col_sums
                # by adding the elements of row r2 to each column's sum
                for c in range(C):
                    current_col_sums[c] += matrix[r2][c]

                # Now, current_col_sums is a 1D array representing the sums of columns
                # for the submatrix defined by rows r1 to r2.
                # The problem reduces to finding the number of subarrays within this 1D array
                # that sum up to the 'target'. This is a standard "Subarray Sum Equals K" problem.

                count_1d_subarrays = 0
                current_sum = 0
                # A hash map to store the frequency of prefix sums encountered so far
                # {prefix_sum: frequency}
                # Initialize with {0: 1} to handle cases where a subarray starting from index 0
                # itself sums to 'target'.
                prefix_sum_counts = {0: 1} 

                for val in current_col_sums:
                    current_sum += val

                    # If (current_sum - target) exists in prefix_sum_counts, it means there is
                    # a previous prefix sum `P_j` such that `current_sum - P_j = target`.
                    # This implies the subarray from the element after `P_j` up to the current element
                    # sums to `target`. The number of such subarrays is the frequency of `(current_sum - target)`.
                    if (current_sum - target) in prefix_sum_counts:
                        count_1d_subarrays += prefix_sum_counts[current_sum - target]

                    # Add the current_sum to the frequency map, or increment its count
                    prefix_sum_counts[current_sum] = prefix_sum_counts.get(current_sum, 0) + 1

                # Add the count of 1D subarrays (for the current r1, r2 slice) to the total
                total_submatrices += count_1d_subarrays

        return total_submatrices