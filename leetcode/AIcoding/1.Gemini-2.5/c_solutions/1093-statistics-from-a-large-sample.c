#include <stdlib.h>

double* sampleStats(int* count, int countSize, int* returnSize) {
    double* result = (double*)malloc(sizeof(double) * 5);
    *returnSize = 5;

    long long total_elements = 0;
    long long sum_values = 0;
    int min_val = 256;
    int max_val = -1;
    int mode_val = -1;
    int max_freq = -1;

    for (int i = 0; i < countSize; i++) {
        if (count[i] > 0) {
            if (i < min_val) {
                min_val = i;
            }
            if (i > max_val) {
                max_val = i;
            }
            if (count[i] > max_freq) {
                max_freq = count[i];
                mode_val = i;
            }
            total_elements += count[i];
            sum_values += (long long)i * count[i];
        }
    }

    result[0] = (double)min_val;
    result[1] = (double)max_val;
    result[4] = (double)mode_val;

    result[2] = (double)sum_values / total_elements;

    int median_pos1 = (total_elements - 1) / 2;
    int median_pos2 = total_elements / 2;

    int val1 = -1, val2 = -1;
    long long current_elements_seen = 0;

    for (int i = 0; i < countSize; i++) {
        if (count[i] > 0) {
            if (val1 == -1 && current_elements_seen <= median_pos1 && current_elements_seen + count[i] > median_pos1) {
                val1 = i;
            }
            if (val2 == -1 && current_elements_seen <= median_pos2 && current_elements_seen + count[i] > median_pos2) {
                val2 = i;
            }
            current_elements_seen += count[i];
        }
    }
    result[3] = (double)(val1 + val2) / 2.0;

    return result;
}