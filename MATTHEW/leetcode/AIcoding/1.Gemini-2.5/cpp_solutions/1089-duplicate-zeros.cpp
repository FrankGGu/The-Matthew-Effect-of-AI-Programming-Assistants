#include <vector>

class Solution {
public:
    void duplicateZeros(std::vector<int>& arr) {
        int n = arr.size();
        int zeros_to_duplicate = 0;
        int i = 0; // Pointer for reading original array
        int j = 0; // Pointer for writing to a conceptual expanded array

        // First pass: Determine how many zeros will be duplicated and where the effective end of the original array is
        while (i < n) {
            if (arr[i] == 0) {
                zeros_to_duplicate++;
                j += 2;
            } else {
                j += 1;
            }

            if (j >= n) {
                break; // We've found the effective end of the original array
            }
            i++;
        }

        int last_read_original_idx = i;
        int write_idx = n - 1; // Write pointer for the modified array

        // Handle the special case where the last zero is only partially duplicated (its second instance falls off)
        if (j > n) { 
            // This means arr[i] was a zero, and its duplication would make j = n + 1.
            // So, only the first instance of this zero fits.
            arr[write_idx] = 0; // Write the single zero
            write_idx--;
            last_read_original_idx--; // Move 'i' back one, as this zero is handled.
            zeros_to_duplicate--; // One less zero to duplicate for the remaining elements.
        }

        // Second pass: Iterate backwards from last_read_original_idx to fill the array
        int read_idx = last_read_original_idx;
        while (read_idx >= 0) {
            if (arr[read_idx] == 0) {
                arr[write_idx] = 0;
                write_idx--;
                arr[write_idx] = 0;
            } else {
                arr[write_idx] = arr[read_idx];
            }
            write_idx--;
            read_idx--;
        }
    }
};