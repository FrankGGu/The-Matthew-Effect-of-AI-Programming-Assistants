#include <stdlib.h> // Required for malloc

int* deepDarkFraction(int* fraction, int fractionSize, int* returnSize) {
    // Use long long for num and den to prevent overflow during intermediate calculations,
    // as the values can grow large before the final result might fit into an int.
    long long num;
    long long den;

    // Initialize with the last term of the continued fraction
    // The innermost fraction is just fraction[fractionSize - 1] / 1
    num = fraction[fractionSize - 1];
    den = 1;

    // Iterate backwards from the second to last term to the first term
    // Each step converts a_i + 1/(previous_fraction)
    // If previous_fraction was prev_num / prev_den, then 1/(previous_fraction) is prev_den / prev_num
    // So, a_i + prev_den / prev_num = (a_i * prev_num + prev_den) / prev_num
    for (int i = fractionSize - 2; i >= 0; i--) {
        long long temp_num = num; // Store the current numerator (which will become the new denominator)
        num = (long long)fraction[i] * num + den; // Calculate the new numerator
        den = temp_num;                           // Update the denominator
    }

    // Allocate memory for the result array
    int* result = (int*)malloc(sizeof(int) * 2);

    // Store the final numerator and denominator
    result[0] = (int)num;
    result[1] = (int)den;

    // Set the returnSize to 2, as the result is a two-element array
    *returnSize = 2;

    return result;
}