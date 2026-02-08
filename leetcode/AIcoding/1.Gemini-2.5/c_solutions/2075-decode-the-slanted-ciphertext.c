#include <stdlib.h>
#include <string.h>

long long calculate_encoded_length(int rows, int cols) {
    long long current_len = 0;
    for (int k = 0; k < cols; k++) {
        // The length of the k-th diagonal (starting at (0, k)) is min(rows, cols - k)
        current_len += (rows < (cols - k) ? rows : (cols - k));
    }
    return current_len;
}

char* decodeCiphertext(char* encodedText, int rows) {
    int L_enc = strlen(encodedText);

    // Handle empty encodedText case
    if (L_enc == 0) {
        char* empty_str = (char*)malloc(sizeof(char));
        if (empty_str == NULL) return NULL;
        empty_str[0] = '\0';
        return empty_str;
    }

    // Step 1: Determine cols using binary search
    // The total length of the encoded text (L_enc) is the sum of the lengths of all diagonals.
    // We need to find 'cols' such that this sum equals L_enc.
    int cols = 0;
    int low = 1;
    // The maximum possible value for cols:
    // If rows = 1, calculate_encoded_length(1, c) = c. So c = L_enc.
    // If rows > 1, calculate_encoded_length(rows, c) > c. So c < L_enc.
    // Thus, 'high' can be L_enc.
    int high = L_enc; 

    // Binary search for cols
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (mid == 0) { // Should not happen with low=1, but as a safeguard
            low = 1; continue;
        }
        long long calculated_len = calculate_encoded_length(rows, mid);

        if (calculated_len == L_enc) {
            cols = mid;
            break;
        }
        if (calculated_len < L_enc) {
            low = mid + 1;
        } else { // calculated_len > L_enc
            high = mid - 1;
        }
    }

    // If cols is 0 after binary search for L_enc > 0, it indicates an inconsistency
    // with the problem's encoding rule and the given encodedText length.
    // For valid inputs, a matching 'cols' should always be found.
    // The problem statement implies that `encodedText` is always a valid encoding.

    // Step 2: Reconstruct the grid and read the message
    // The grid size is rows x cols.
    // Allocate memory for the decoded string (original message).
    // Max length is rows * cols + 1 for null terminator.
    char* decoded_message = (char*)malloc(sizeof(char) * (rows * cols + 1));
    if (decoded_message == NULL) {
        return NULL; // Handle allocation failure
    }

    // Initialize the decoded message with spaces.
    // Characters not covered by diagonals (i.e., grid cells where c < r) will remain spaces.
    for (int i = 0; i < rows * cols; i++) {
        decoded_message[i] = ' ';
    }
    decoded_message[rows * cols] = '\0';

    int current_encoded_idx = 0;
    // Iterate through starting columns of diagonals (diag_start_col from 0 to cols-1)
    for (int diag_start_col = 0; diag_start_col < cols; diag_start_col++) {
        // Iterate along the current diagonal (r_in_diag from 0 to rows-1)
        for (int r_in_diag = 0; r_in_diag < rows; r_in_diag++) {
            int c_in_diag = diag_start_col + r_in_diag;

            // If the diagonal goes out of bounds for columns, stop reading this diagonal
            if (c_in_diag >= cols) {
                break;
            }

            // The character at encodedText[current_encoded_idx] corresponds to grid[r_in_diag][c_in_diag]
            // In a 1D array representing a grid, grid[r][c] is at index r * cols + c
            decoded_message[r_in_diag * cols + c_in_diag] = encodedText[current_encoded_idx];
            current_encoded_idx++;
        }
    }

    // Step 3: Remove trailing spaces from the decoded message
    int current_len = rows * cols;
    while (current_len > 0 && decoded_message[current_len - 1] == ' ') {
        current_len--;
    }
    decoded_message[current_len] = '\0';

    return decoded_message;
}