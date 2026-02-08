#include <stddef.h> // For size_t
#include <limits.h> // For LLONG_MIN

long long maxWeeks(int* milestones, int milestonesSize) {
    long long total_sum = 0;
    long long max_val = 0; 

    for (int i = 0; i < milestonesSize; i++) {
        total_sum += milestones[i];
        if (milestones[i] > max_val) {
            max_val = milestones[i];
        }
    }

    long long other_sum = total_sum - max_val;

    if (max_val <= other_sum + 1) {
        return total_sum;
    } else {
        return 2 * other_sum + 1;
    }
}