#include <stdlib.h>
#include <limits.h>

typedef struct {
    int val;
    int idx;
} Element;

int compareElements(const void* a, const void* b) {
    Element* elemA = (Element*)a;
    Element* elemB = (Element*)b;
    if (elemA->val != elemB->val) {
        return elemA->val - elemB->val;
    }
    return elemA->idx - elemB->idx;
}

int minimumSeconds(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    Element* temp_arr = (Element*)malloc(numsSize * sizeof(Element));
    for (int i = 0; i < numsSize; i++) {
        temp_arr[i].val = nums[i];
        temp_arr[i].idx = i;
    }

    qsort(temp_arr, numsSize, sizeof(Element), compareElements);

    int min_total_seconds = INT_MAX;

    int i = 0;
    while (i < numsSize) {
        int current_val = temp_arr[i].val;
        int max_dist_for_value = 0;

        int start_idx_in_temp_arr = i;
        int j = i;
        while (j < numsSize && temp_arr[j].val == current_val) {
            j++;
        }
        int end_idx_in_temp_arr = j - 1;
        int k = (end_idx_in_temp_arr - start_idx_in_temp_arr) + 1;

        if (k == 1) {
            max_dist_for_value = numsSize;
        } else {
            for (int l = 0; l < k - 1; l++) {
                int current_dist = temp_arr[start_idx_in_temp_arr + l + 1].idx - temp_arr[start_idx_in_temp_arr + l].idx;
                if (current_dist > max_dist_for_value) {
                    max_dist_for_value = current_dist;
                }
            }
            int circular_dist = numsSize - temp_arr[end_idx_in_temp_arr].idx + temp_arr[start_idx_in_temp_arr].idx;
            if (circular_dist > max_dist_for_value) {
                max_dist_for_value = circular_dist;
            }
        }

        int seconds_for_value = max_dist_for_value / 2;
        if (seconds_for_value < min_total_seconds) {
            min_total_seconds = seconds_for_value;
        }

        i = j;
    }

    free(temp_arr);

    return min_total_seconds;
}