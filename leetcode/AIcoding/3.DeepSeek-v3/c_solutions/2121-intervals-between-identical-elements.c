/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* getDistances(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    long long* res = (long long*)malloc(arrSize * sizeof(long long));
    for (int i = 0; i < arrSize; i++) {
        res[i] = 0;
    }

    int max_val = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > max_val) max_val = arr[i];
    }

    int* count = (int*)calloc(max_val + 1, sizeof(int));
    long long* prefix_sum = (long long*)calloc(max_val + 1, sizeof(long long));
    long long* suffix_sum = (long long*)calloc(max_val + 1, sizeof(long long));
    int* last_prefix_index = (int*)calloc(max_val + 1, sizeof(int));
    int* last_suffix_index = (int*)calloc(max_val + 1, sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        int val = arr[i];
        res[i] += (long long)count[val] * i - prefix_sum[val];
        prefix_sum[val] += i;
        count[val]++;
        last_prefix_index[val] = i;
    }

    for (int i = 0; i <= max_val; i++) {
        count[i] = 0;
    }

    for (int i = arrSize - 1; i >= 0; i--) {
        int val = arr[i];
        res[i] += suffix_sum[val] - (long long)count[val] * i;
        suffix_sum[val] += i;
        count[val]++;
        last_suffix_index[val] = i;
    }

    free(count);
    free(prefix_sum);
    free(suffix_sum);
    free(last_prefix_index);
    free(last_suffix_index);

    return res;
}