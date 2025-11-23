/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* sumZero(int n, int* returnSize) {
    *returnSize = n;
    int* result = (int*)malloc(n * sizeof(int));

    if (n % 2 == 1) {
        result[0] = 0;
        for (int i = 1; i < n; i += 2) {
            result[i] = i;
            result[i + 1] = -i;
        }
    } else {
        for (int i = 0; i < n; i += 2) {
            result[i] = i + 1;
            result[i + 1] = -(i + 1);
        }
    }

    return result;
}