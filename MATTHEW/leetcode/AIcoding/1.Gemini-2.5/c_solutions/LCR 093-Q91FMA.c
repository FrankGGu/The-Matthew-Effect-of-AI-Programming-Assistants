#include <stdlib.h>
#include <string.h>

int find_index_in_prefix(int* arr, int n_search, int val) {
    int low = 0;
    int high = n_search - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] == val) {
            return mid;
        }
        if (arr[mid] < val) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -1;
}

int lenLongestFibSubsequence(int* arr, int arrSize) {
    int n = arrSize;

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; ++i) {
        dp[i] = (int*)malloc(n * sizeof(int));
        memset(dp[i], 0, n * sizeof(int));
    }

    int max_len = 0;

    for (int j = 0; j < n; ++j) {
        for (int i = 0; i < j; ++i) {
            int target = arr[j] - arr[i];

            if (target < arr[i]) {
                int k = find_index_in_prefix(arr, i, target);
                if (k != -1) {
                    dp[i][j] = (dp[k][i] == 0) ? 3 : dp[k][i] + 1;
                    if (dp[i][j] > max_len) {
                        max_len = dp[i][j];
                    }
                }
            }
        }
    }

    for (int i = 0; i < n; ++i) {
        free(dp[i]);
    }
    free(dp);

    return max_len;
}