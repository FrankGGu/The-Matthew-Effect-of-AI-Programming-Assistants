#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxScoreSightseeingPair(int* values, int valuesSize) {
    int max_score = INT_MIN;
    int max_i_plus_val = values[0] + 0;

    for (int j = 1; j < valuesSize; j++) {
        max_score = max(max_score, max_i_plus_val + values[j] - j);
        max_i_plus_val = max(max_i_plus_val, values[j] + j);
    }

    return max_score;
}