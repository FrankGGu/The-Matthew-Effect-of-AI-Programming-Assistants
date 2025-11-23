#include <stdlib.h> // Required for min function if not defined manually

int min(int a, int b) {
    return (a < b) ? a : b;
}

int calculate_rotations(int target, int* A, int* B, int n) {
    int rotations_to_make_A_target = 0; // Rotations needed to make row A all 'target'
    int rotations_to_make_B_target = 0; // Rotations needed to make row B all 'target'

    for (int i = 0; i < n; i++) {
        // If neither A[i] nor B[i] is the target, then it's impossible to make
        // either row A or row B entirely of 'target' values.
        if (A[i] != target && B[i] != target) {
            return -1;
        }

        // If A[i] is not the target, we must use B[i] (which must be target due to the check above)
        // to make A[i] the target. This counts as a rotation for row A.
        if (A[i] != target) {
            rotations_to_make_A_target++;
        }

        // If B[i] is not the target, we must use A[i] (which must be target due to the check above)
        // to make B[i] the target. This counts as a rotation for row B.
        if (B[i] != target) {
            rotations_to_make_B_target++;
        }
    }

    // Return the minimum rotations required to make either row A or row B entirely 'target'.
    return min(rotations_to_make_A_target, rotations_to_make_B_target);
}

int minDominoRotations(int* A, int ASize, int* B, int BSize) {
    int n = ASize; // ASize and BSize are guaranteed to be the same

    // We only need to check two potential target values: A[0] and B[0].
    // If a solution exists, the common value must be either A[0] or B[0] (or both if A[0]==B[0]).

    // Case 1: Try to make all elements 'A[0]'
    int rotations1 = calculate_rotations(A[0], A, B, n);

    // Case 2: Try to make all elements 'B[0]'
    // If A[0] == B[0], this call will yield the same result as rotations1,
    // but it's harmless and simplifies the logic.
    int rotations2 = calculate_rotations(B[0], A, B, n);

    // Determine the overall minimum rotations from the two possibilities.
    if (rotations1 == -1 && rotations2 == -1) {
        return -1; // Impossible for both potential targets
    } else if (rotations1 == -1) {
        return rotations2; // Only rotations2 is a valid option
    } else if (rotations2 == -1) {
        return rotations1; // Only rotations1 is a valid option
    } else {
        return min(rotations1, rotations2); // Both are valid, return the smaller one
    }
}