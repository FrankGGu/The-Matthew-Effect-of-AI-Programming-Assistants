/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* productQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int powers[32];
    int powerCount = 0;

    for (int i = 0; i < 32; i++) {
        if (n & (1 << i)) {
            powers[powerCount++] = (1 << i);
        }
    }

    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int left = queries[i][0];
        int right = queries[i][1];
        long long product = 1;

        for (int j = left; j <= right; j++) {
            product = (product * powers[j]) % 1000000007;
        }

        result[i] = (int)product;
    }

    return result;
}