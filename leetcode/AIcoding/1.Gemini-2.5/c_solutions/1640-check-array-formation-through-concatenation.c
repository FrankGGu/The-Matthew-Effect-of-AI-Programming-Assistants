#include <stdbool.h>
#include <string.h> // For memset, though it's not strictly necessary if we initialize manually

bool canFormArray(int* arr, int arrSize, int** pieces, int piecesSize, int* piecesColSize) {
    // piece_map will store the index of the piece that starts with a given value.
    // Since values are between 1 and 100, an array of size 101 is sufficient.
    // Initialize with -1 to indicate no piece starts with that value.
    int piece_map[101];
    for (int i = 0; i <= 100; ++i) {
        piece_map[i] = -1;
    }

    // Populate the map: map the first element of each piece to its index in the pieces array.
    for (int i = 0; i < piecesSize; ++i) {
        piece_map[pieces[i][0]] = i;
    }

    // Iterate through the target array 'arr'.
    int arr_idx = 0;
    while (arr_idx < arrSize) {
        int current_val = arr[arr_idx];

        // Check if there's any piece that starts with the current value from 'arr'.
        if (current_val < 1 || current_val > 100 || piece_map[current_val] == -1) {
            return false; // No piece found that starts with arr[arr_idx]
        }

        // Get the index of the piece that matches.
        int piece_idx = piece_map[current_val];
        int* current_piece = pieces[piece_idx];
        int current_piece_len = piecesColSize[piece_idx];

        // Compare the current segment of 'arr' with the found piece.
        for (int j = 0; j < current_piece_len; ++j) {
            // Check for out-of-bounds access on arr or a mismatch.
            if (arr_idx + j >= arrSize || arr[arr_idx + j] != current_piece[j]) {
                return false; // Mismatch found
            }
        }

        // If the piece matched, advance the arr_idx by the length of the matched piece.
        arr_idx += current_piece_len;
    }

    // If we successfully iterated through the entire 'arr', it means it can be formed.
    return true;
}