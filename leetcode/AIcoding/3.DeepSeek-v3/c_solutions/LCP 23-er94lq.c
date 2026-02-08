/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* magicalArray(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    if (n == 1) {
        result[0] = 1;
        return result;
    }

    int left = 0, right = n - 1;
    int num = 1;

    while (left <= right) {
        if (left == right) {
            result[left] = num;
            break;
        }

        result[left++] = num;
        result[right--] = num + 1;
        num += 2;
    }

    return result;
}