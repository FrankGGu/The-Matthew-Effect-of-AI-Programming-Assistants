class Solution {
    public void duplicateZeros(int[] arr) {
        int n = arr.length;
        int i = 0; // Read pointer for original array
        int j = 0; // Write pointer for potentially longer array (before truncation)

        // First pass: Determine the effective end of the original array to consider
        // and the final position of the elements if all zeros were duplicated.
        while (j < n) {
            if (arr[i] == 0) {
                j += 2;
            } else {
                j += 1;
            }
            if (j >= n) { // We've found the boundary where elements start to be truncated
                break;
            }
            i++;
        }

        // After this loop:
        // `i` is the index of the last element from the original array that we might process.
        // `j` is the total length needed for elements `arr[0]` to `arr[i]` (inclusive) if zeros are duplicated.

        // Initialize write_ptr and read_ptr for the second pass (from right to left).
        int write_ptr = n - 1;
        int read_ptr = i;

        // Handle the special case where the last zero would overflow if duplicated twice.
        // In this case, it's duplicated only once, filling the last spot `arr[n-1]`.
        if (j > n) { // This implies `j == n + 1` and `arr[i]` was a zero.
            arr[write_ptr] = 0; // Write the single zero at the last position
            write_ptr--;        // Move write_ptr one step left
            read_ptr--;         // Move read_ptr one step left to the element before this special zero
        }

        // Second pass: Fill the array from right to left.
        // `read_ptr` points to the last element of the original array to process.
        // `write_ptr` points to the last available slot in `arr`.
        while (read_ptr >= 0) {
            if (arr[read_ptr] == 0) {
                arr[write_ptr] = 0;
                write_ptr--;
                arr[write_ptr] = 0;
                write_ptr--;
            } else {
                arr[write_ptr] = arr[read_ptr];
                write_ptr--;
            }
            read_ptr--;
        }
    }
}