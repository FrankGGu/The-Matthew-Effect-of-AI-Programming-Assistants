#include <stdlib.h> // Required for qsort and calloc

int compare(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int findIndex(int val, int* arr, int n) {
    int low = 0, high = n - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] == val) {
            return mid;
        } else if (arr[mid] < val) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -1; // Not found
}

int numFactoredBinaryTrees(int* arr, int arrSize) {
    long long MOD = 1000000007;

    qsort(arr, arrSize, sizeof(int), compare);

    long long* dp = (long long*)calloc(arrSize, sizeof(long long));
    if (dp == NULL) {
        return 0; 
    }

    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1; // Each number itself forms a tree
    }

    for (int i = 0; i < arrSize; i++) { // arr[i] is the root
        for (int j = 0; j < i; j++) { // arr[j] is the left child
            if (arr[i] % arr[j] == 0) {
                int right_val = arr[i] / arr[j];

                int idx_right = findIndex(right_val, arr, arrSize);

                if (idx_right != -1) {
                    dp[i] = (dp[i] + dp[j] * dp[idx_right]) % MOD;
                }
            }
        }
    }

    long long totalTrees = 0;
    for (int i = 0; i < arrSize; i++) {
        totalTrees = (totalTrees + dp[i]) % MOD;
    }

    free(dp);

    return (int)totalTrees;
}