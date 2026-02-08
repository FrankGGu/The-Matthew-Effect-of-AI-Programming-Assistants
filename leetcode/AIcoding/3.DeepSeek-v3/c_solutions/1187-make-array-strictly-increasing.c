int dp[2001][2001];

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int binarySearch(int* arr, int size, int target) {
    int left = 0, right = size - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return left;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int makeArrayIncreasing(int* arr1, int arr1Size, int* arr2, int arr2Size) {
    qsort(arr2, arr2Size, sizeof(int), cmp);

    int uniqueSize = 0;
    for (int i = 0; i < arr2Size; i++) {
        if (i == 0 || arr2[i] != arr2[i - 1]) {
            arr2[uniqueSize++] = arr2[i];
        }
    }

    int n = arr1Size;
    int m = uniqueSize;

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= m; j++) {
            dp[i][j] = INT_MAX;
        }
    }

    dp[0][0] = INT_MIN;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j <= min(i, m); j++) {
            if (arr1[i - 1] > dp[i - 1][j]) {
                dp[i][j] = min(dp[i][j], arr1[i - 1]);
            }
            if (j > 0) {
                int idx = binarySearch(arr2, m, dp[i - 1][j - 1]);
                if (idx < m) {
                    dp[i][j] = min(dp[i][j], arr2[idx]);
                }
            }
        }
    }

    for (int j = 0; j <= m; j++) {
        if (dp[n][j] != INT_MAX) {
            return j;
        }
    }

    return -1;
}