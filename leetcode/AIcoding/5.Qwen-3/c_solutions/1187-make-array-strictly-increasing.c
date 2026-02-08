#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int makeArrayStrictlyIncreasing(int* arr, int arrSize) {
    int* dp = (int*)malloc(arrSize * sizeof(int));
    int* prev = (int*)malloc(arrSize * sizeof(int));
    int* index = (int*)malloc(arrSize * sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1;
        prev[i] = -1;
        index[i] = i;
    }

    for (int i = 1; i < arrSize; i++) {
        for (int j = 0; j < i; j++) {
            if (arr[j] < arr[i] && dp[j] + 1 > dp[i]) {
                dp[i] = dp[j] + 1;
                prev[i] = j;
            }
        }
    }

    int max_len = 0;
    int last_index = 0;
    for (int i = 0; i < arrSize; i++) {
        if (dp[i] > max_len) {
            max_len = dp[i];
            last_index = i;
        }
    }

    int* result = (int*)malloc(max_len * sizeof(int));
    int k = max_len - 1;
    while (last_index != -1) {
        result[k--] = arr[last_index];
        last_index = prev[last_index];
    }

    int* new_arr = (int*)malloc(max_len * sizeof(int));
    for (int i = 0; i < max_len; i++) {
        new_arr[i] = result[i];
    }

    free(dp);
    free(prev);
    free(index);
    free(result);

    int* final_arr = (int*)malloc((arrSize - max_len) * sizeof(int));
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        int found = 0;
        for (int j = 0; j < max_len; j++) {
            if (arr[i] == new_arr[j]) {
                found = 1;
                break;
            }
        }
        if (!found) {
            final_arr[count++] = arr[i];
        }
    }

    free(new_arr);

    int* answer = (int*)malloc(count * sizeof(int));
    for (int i = 0; i < count; i++) {
        answer[i] = final_arr[i];
    }

    free(final_arr);

    return answer[0];
}