#include <stddef.h>

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long max(long long a, long long b) {
    return a > b ? a : b;
}

int countHiddenSequences(int* differences, int differencesSize, int lower, int upper) {
    long long current_sum = 0;
    long long min_s = 0;
    long long max_s = 0;

    for (int i = 0; i < differencesSize; i++) {
        current_sum += differences[i];
        min_s = min(min_s, current_sum);
        max_s = max(max_s, current_sum);
    }

    // We need to find the number of possible values for b[0] (let's call it 'start_val').
    // The sequence elements are b[i] = start_val + current_prefix_sum[i].
    // The condition is lower <= b[i] <= upper for all i.
    // This means:
    // lower <= start_val + min_s  =>  start_val >= lower - min_s
    // upper >= start_val + max_s  =>  start_val <= upper - max_s
    // So, start_val must be in the range [lower - min_s, upper - max_s].
    // The number of integers in this range is (upper - max_s) - (lower - min_s) + 1.

    long long count = (long long)upper - (long long)lower - (max_s - min_s) + 1;

    if (count < 0) {
        return 0;
    } else {
        return (int)count;
    }
}