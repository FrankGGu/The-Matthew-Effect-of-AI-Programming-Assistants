/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* cycleLengthQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* res = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int b = queries[i][1];
        int len = 1;

        while (a != b) {
            if (a > b) {
                a /= 2;
            } else {
                b /= 2;
            }
            len++;
        }

        res[i] = len;
    }

    return res;
}