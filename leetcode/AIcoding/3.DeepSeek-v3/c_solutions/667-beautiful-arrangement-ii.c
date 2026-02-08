/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* constructArray(int n, int k, int* returnSize) {
    int* res = (int*)malloc(n * sizeof(int));
    *returnSize = n;
    int left = 1, right = n;
    int idx = 0;

    for (int i = 0; i < k; i++) {
        if (i % 2 == 0) {
            res[idx++] = left++;
        } else {
            res[idx++] = right--;
        }
    }

    if (k % 2 == 1) {
        while (idx < n) {
            res[idx++] = left++;
        }
    } else {
        while (idx < n) {
            res[idx++] = right--;
        }
    }

    return res;
}