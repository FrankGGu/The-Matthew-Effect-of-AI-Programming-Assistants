/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* getNoZeroIntegers(int n, int* returnSize) {
    *returnSize = 2;
    int* result = (int*)malloc(2 * sizeof(int));

    for (int a = 1; a < n; a++) {
        int b = n - a;
        if (isNoZero(a) && isNoZero(b)) {
            result[0] = a;
            result[1] = b;
            return result;
        }
    }

    result[0] = 1;
    result[1] = n - 1;
    return result;
}

int isNoZero(int num) {
    while (num > 0) {
        if (num % 10 == 0) {
            return 0;
        }
        num /= 10;
    }
    return 1;
}