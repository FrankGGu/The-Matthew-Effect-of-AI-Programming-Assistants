int* circularPermutation(int n, int start, int* returnSize) {
    *returnSize = 1 << n;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = ((i >> 0) ^ (i >> 1) ^ start) & ((1 << n) - 1);
    }
    return result;
}