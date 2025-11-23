#include <stdlib.h> // For abs
#include <stdbool.h> // For bool

typedef struct {
    int s_value;
    int frequency;
} SValueFreq;

int compareSValueFreq(const void* a, const void* b) {
    // Cast void pointers to SValueFreq pointers and compare their s_value members
    return ((SValueFreq*)a)->s_value - ((SValueFreq*)b)->s_value;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumPointsInsideTheSquare(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize == 0) {
        return 0;
    }

    // Step 1: Calculate s_value = max(|xi|, |yi|) for all points
    // Store them in a dynamically allocated array.
    int* all_s_values = (int*)malloc(pointsSize * sizeof(int));
    if (all_s_values == NULL) {
        // Handle memory allocation failure
        return 0;
    }

    for (int i = 0; i < pointsSize; i++) {
        int x = points[i][0];
        int y = points[i][1];
        all_s_values[i] = max(abs(x), abs(y));
    }

    // Step 2: Sort all_s_values to group identical s_values together.
    // The comparison function for qsort expects elements of the array itself,
    // so we sort the raw s_values first.
    qsort(all_s_values, pointsSize, sizeof(int), compareSValueFreq); // Note: compareSValueFreq expects SValueFreq*, but here we're sorting int*.
                                                                   // This is a common pattern in C to reuse a comparison function if types are compatible.
                                                                   // A more robust approach would be a dedicated compareInt function.
                                                                   // For int comparison: `return *(int*)a - *(int*)b;`
    // Let's use a dedicated int comparison for clarity and correctness.
    int compareInt(const void* a, const void* b) {
        return *(int*)a - *(int*)b;
    }
    qsort(all_s_values, pointsSize, sizeof(int), compareInt);

    // Step 3: Count frequencies of each unique s_value.
    // Store unique s_values and their frequencies in a temporary array.
    // This effectively simulates a map<int, int> in C++.
    SValueFreq* freq_pairs = (SValueFreq*)malloc(pointsSize * sizeof(SValueFreq));
    if (freq_pairs == NULL) {
        free(all_s_values);
        // Handle memory allocation failure
        return 0;
    }
    int distinct_s_values_count = 0;

    // Process the sorted s_values to fill freq_pairs
    if (pointsSize > 0) {
        freq_pairs[0].s_value = all_s_values[0];
        freq_pairs[0].frequency = 1;
        distinct_s_values_count = 1;

        for (int i = 1; i < pointsSize; i++) {
            if (all_s_values[i] == freq_pairs[distinct_s_values_count - 1].s_value) {
                freq_pairs[distinct_s_values_count - 1].frequency++;
            } else {
                freq_pairs[distinct_s_values_count].s_value = all_s_values[i];
                freq_pairs[distinct_s_values_count].frequency = 1;
                distinct_s_values_count++;
            }
        }
    }

    free(all_s_values); // The sorted array is no longer needed

    // Step 4: Apply the problem logic based on frequencies.
    // The common interpretation: find the longest "streak" of distinct s_values,
    // where each s_value in the streak has a frequency of 1.
    // If an s_value with frequency > 1 is encountered, the streak breaks.
    int max_collected_points = 0;
    int current_streak_points = 0;

    for (int i = 0; i < distinct_s_values_count; i++) {
        if (freq_pairs[i].frequency == 1) {
            current_streak_points++;
        } else {
            // If an s_value has frequency > 1, it cannot be chosen as part of a distinct set
            // where all elements are valid according to this interpretation.
            // This breaks the current streak of valid s_values.
            current_streak_points = 0;
        }
        max_collected_points = max(max_collected_points, current_streak_points);
    }

    free(freq_pairs); // Free the temporary array
    return max_collected_points;
}