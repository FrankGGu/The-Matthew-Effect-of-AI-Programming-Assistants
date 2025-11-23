#include <stdlib.h> // For qsort
#include <math.h>   // For fmin, though ternary operator is used for long long

int compareFruits(const void *a, const void *b) {
    const int *fruitA = *(const int **)a;
    const int *fruitB = *(const int **)b;
    return fruitA[0] - fruitB[0];
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

int get_max_fruits(int** fruits, int fruitsSize, int* fruitsColSize, int startPos, int k) {
    // Sort fruits by position
    qsort(fruits, fruitsSize, sizeof(int*), compareFruits);

    long long max_fruits = 0;
    long long current_fruits_sum = 0;
    int left_idx = 0;

    // Convert startPos and k to long long for calculations to prevent overflow
    long long s = (long long)startPos;
    long long K_ll = (long long)k;

    for (int right_idx = 0; right_idx < fruitsSize; ++right_idx) {
        current_fruits_sum += fruits[right_idx][1];

        // The 'while' loop adjusts the left_idx to maintain a valid window
        while (left_idx <= right_idx) {
            long long L = (long long)fruits[left_idx][0];
            long long R = (long long)fruits[right_idx][0];

            long long dist;

            // Calculate distance for the current window [L, R] starting from s
            if (s < L) { // startPos is to the left of the collected range
                dist = R - s;
            } else if (s > R) { // startPos is to the right of the collected range
                dist = s - L;
            } else { // startPos is within the collected range [L, R]
                // Option 1: Go left to L, then turn and go right to R
                long long dist1 = (s - L) + (R - L);
                // Option 2: Go right to R, then turn and go left to L
                long long dist2 = (R - s) + (R - L);
                dist = min(dist1, dist2);
            }

            if (dist <= K_ll) {
                // This window [left_idx, right_idx] is valid.
                // For the current right_idx, this left_idx provides the maximum fruits
                // because moving left_idx further right would only decrease the sum.
                // So, we can break from the inner while loop and move to the next right_idx.
                break;
            } else {
                // The current window is invalid (distance > k).
                // Shrink the window from the left by moving left_idx to the right.
                current_fruits_sum -= fruits[left_idx][1];
                left_idx++;
            }
        }

        // After the while loop, if left_idx is still <= right_idx, it means a valid window was found.
        // If left_idx > right_idx, the window is empty or no valid window could be formed for current right_idx.
        if (left_idx <= right_idx) {
            max_fruits = max(max_fruits, current_fruits_sum);
        }
    }

    return (int)max_fruits;
}