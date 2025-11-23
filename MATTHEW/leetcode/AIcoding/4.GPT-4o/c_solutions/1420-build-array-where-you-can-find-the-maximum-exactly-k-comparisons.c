int* maxArray(int n, int k, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    int maxNum = n;
    for (int i = 0; i < n; i++) {
        if (k > 0) {
            result[i] = maxNum--;
            k--;
        } else {
            result[i] = 1;
        }
    }
    return result;
}