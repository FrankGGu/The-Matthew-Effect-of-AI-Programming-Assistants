/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* circularPermutation(int n, int start, int* returnSize) {
    int total = 1 << n;
    int* result = (int*)malloc(total * sizeof(int));
    *returnSize = total;

    for (int i = 0; i < total; i++) {
        result[i] = start ^ i ^ (i >> 1);
    }

    return result;
}