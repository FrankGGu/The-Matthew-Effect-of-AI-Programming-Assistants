int upper_bound(int* arr, int size, int target) {
    int left = 0, right = size;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}

int kIncreasing(int* arr, int arrSize, int k) {
    int result = 0;
    for (int i = 0; i < k; i++) {
        int len = 0;
        for (int j = i; j < arrSize; j += k) {
            len++;
        }
        int* dp = (int*)malloc(len * sizeof(int));
        int lis_len = 0;
        for (int j = i, idx = 0; j < arrSize; j += k, idx++) {
            int pos = upper_bound(dp, lis_len, arr[j]);
            if (pos == lis_len) {
                dp[lis_len++] = arr[j];
            } else {
                dp[pos] = arr[j];
            }
        }
        result += len - lis_len;
        free(dp);
    }
    return result;
}