/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* kthPalindrome(int* queries, int queriesSize, int intLength, int* returnSize) {
    long long* result = (long long*)malloc(queriesSize * sizeof(long long));
    *returnSize = queriesSize;

    int halfLength = (intLength + 1) / 2;
    long long start = 1;
    for (int i = 1; i < halfLength; i++) {
        start *= 10;
    }
    long long end = start * 10 - 1;

    for (int i = 0; i < queriesSize; i++) {
        int idx = queries[i] - 1;
        if (idx > end - start) {
            result[i] = -1;
            continue;
        }

        long long half = start + idx;
        long long pal = half;

        if (intLength % 2 == 1) {
            half /= 10;
        }

        while (half > 0) {
            pal = pal * 10 + (half % 10);
            half /= 10;
        }

        result[i] = pal;
    }

    return result;
}