#include <stdlib.h>
#include <string.h>

int get_first_candle_pos(int* candle_indices, int num_candles, int target_left) {
    if (num_candles == 0) return -1;
    int low = 0, high = num_candles - 1;
    int result_idx_in_arr = -1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (candle_indices[mid] >= target_left) {
            result_idx_in_arr = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return result_idx_in_arr == -1 ? -1 : candle_indices[result_idx_in_arr];
}

int get_last_candle_pos(int* candle_indices, int num_candles, int target_right) {
    if (num_candles == 0) return -1;
    int low = 0, high = num_candles - 1;
    int result_idx_in_arr = -1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (candle_indices[mid] <= target_right) {
            result_idx_in_arr = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return result_idx_in_arr == -1 ? -1 : candle_indices[result_idx_in_arr];
}

int* platesBetweenCandles(char* s, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int n = strlen(s);

    int* prefix_plates = (int*)malloc((n + 1) * sizeof(int));
    prefix_plates[0] = 0;
    for (int i = 0; i < n; ++i) {
        prefix_plates[i + 1] = prefix_plates[i] + (s[i] == '*' ? 1 : 0);
    }

    int num_candles = 0;
    for (int i = 0; i < n; ++i) {
        if (s[i] == '|') {
            num_candles++;
        }
    }

    int* candle_indices = (int*)malloc(num_candles * sizeof(int));
    int k = 0;
    for (int i = 0; i < n; ++i) {
        if (s[i] == '|') {
            candle_indices[k++] = i;
        }
    }

    int* results = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int q = 0; q < queriesSize; ++q) {
        int left = queries[q][0];
        int right = queries[q][1];

        int first_candle_s_idx = get_first_candle_pos(candle_indices, num_candles, left);
        int last_candle_s_idx = get_last_candle_pos(candle_indices, num_candles, right);

        if (first_candle_s_idx != -1 && last_candle_s_idx != -1 && first_candle_s_idx < last_candle_s_idx) {
            results[q] = prefix_plates[last_candle_s_idx] - prefix_plates[first_candle_s_idx + 1];
        } else {
            results[q] = 0;
        }
    }

    free(prefix_plates);
    free(candle_indices);

    return results;
}