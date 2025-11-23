#include <stdio.h> // Required for NULL, though not strictly used here.
                   // Not needed for the provided solution logic, but common for C.

int getDigitSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int maximumSum(int* nums, int numsSize) {
    // The maximum possible sum of digits for a number up to 10^9 is for 999,999,999,
    // which is 9 * 9 = 81. So, an array of size 90 (indices 0-89) is sufficient
    // to store information for all possible digit sums.
    int largest1[90]; // Stores the largest number found for a specific digit sum.
    int largest2[90]; // Stores the second largest number found for a specific digit sum.

    // Initialize arrays to 0. Since all numbers in `nums` are positive (1 to 10^9),
    // 0 can serve as a sentinel value indicating that no number has been stored yet
    // for that particular digit sum, or only one number (if largest1 is non-zero but largest2 is zero).
    for (int i = 0; i < 90; ++i) {
        largest1[i] = 0;
        largest2[i] = 0;
    }

    // Iterate through all numbers in the input array.
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        int digit_sum = getDigitSum(num);

        // Update largest1 and largest2 for the current digit_sum.
        if (num > largest1[digit_sum]) {
            // If the current number is greater than the current largest,
            // the current largest becomes the second largest, and the new number becomes the largest.
            largest2[digit_sum] = largest1[digit_sum];
            largest1[digit_sum] = num;
        } else if (num > largest2[digit_sum]) {
            // If the current number is not greater than the largest, but is greater than
            // the second largest, then it becomes the new second largest.
            largest2[digit_sum] = num;
        }
    }

    int max_overall_sum = -1; // Initialize to -1 as per problem requirements (if no such pair exists).

    // Iterate through all possible digit sums to find the maximum pair sum.
    for (int i = 0; i < 90; ++i) {
        // A valid pair exists if both largest1 and largest2 for a digit sum are non-zero.
        // This means we found at least two distinct numbers with this digit sum.
        if (largest1[i] != 0 && largest2[i] != 0) {
            int current_pair_sum = largest1[i] + largest2[i];
            // Update the overall maximum sum if the current pair sum is greater.
            if (current_pair_sum > max_overall_sum) {
                max_overall_sum = current_pair_sum;
            }
        }
    }

    return max_overall_sum;
}