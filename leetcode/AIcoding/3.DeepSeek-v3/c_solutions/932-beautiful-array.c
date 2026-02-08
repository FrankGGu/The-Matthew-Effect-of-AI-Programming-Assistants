/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* beautifulArray(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    result[0] = 1;

    int size = 1;
    while (size < n) {
        int* temp = (int*)malloc(size * 2 * sizeof(int));
        int idx = 0;

        for (int i = 0; i < size; i++) {
            if (result[i] * 2 - 1 <= n) {
                temp[idx++] = result[i] * 2 - 1;
            }
        }

        for (int i = 0; i < size; i++) {
            if (result[i] * 2 <= n) {
                temp[idx++] = result[i] * 2;
            }
        }

        free(result);
        result = temp;
        size = idx;
    }

    return result;
}