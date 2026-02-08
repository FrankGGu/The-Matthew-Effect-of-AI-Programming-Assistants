/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* addNegabinary(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int maxLen = (arr1Size > arr2Size ? arr1Size : arr2Size) + 2;
    int* result = (int*)calloc(maxLen, sizeof(int));
    int i = arr1Size - 1, j = arr2Size - 1, k = maxLen - 1;
    int carry = 0;

    while (i >= 0 || j >= 0 || carry) {
        if (i >= 0) carry += arr1[i--];
        if (j >= 0) carry += arr2[j--];
        result[k--] = carry & 1;
        carry = -(carry >> 1);
    }

    while (k + 1 < maxLen && result[k + 1] == 0) k++;

    if (k == maxLen - 1) {
        *returnSize = 1;
        int* zero = (int*)malloc(sizeof(int));
        zero[0] = 0;
        free(result);
        return zero;
    }

    *returnSize = maxLen - k - 1;
    int* final = (int*)malloc(*returnSize * sizeof(int));
    memcpy(final, result + k + 1, *returnSize * sizeof(int));
    free(result);
    return final;
}