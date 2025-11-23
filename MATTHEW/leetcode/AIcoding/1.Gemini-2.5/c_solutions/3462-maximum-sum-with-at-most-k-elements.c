#include <stddef.h> // For size_t

long long maxScore(int* nums, int numsSize, int k) {
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    long long score = 0;
    // The sequence of numbers added to the score will be:
    // max_val, (max_val + 1), (max_val + 2), ..., (max_val + k - 1)
    // This is an arithmetic progression.
    // The sum of an arithmetic progression is (number_of_terms / 2) * (first_term + last_term)
    // Here, number_of_terms = k
    // first_term = max_val
    // last_term = max_val + (k - 1)
    // Sum = k * (max_val + (max_val + k - 1)) / 2  -- This is incorrect, formula for sum is different
    // Sum = k * first_term + (k-1)*k/2 * common_difference
    // Sum = k * max_val + (k-1)*k/2  (since common_difference is 1)

    score = (long long)k * max_val + (long long)(k - 1) * k / 2;

    return score;
}