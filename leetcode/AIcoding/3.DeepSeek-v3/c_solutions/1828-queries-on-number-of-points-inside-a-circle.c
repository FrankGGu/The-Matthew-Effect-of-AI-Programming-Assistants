/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* countPoints(int** points, int pointsSize, int* pointsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int count = 0;
        int x = queries[i][0];
        int y = queries[i][1];
        int r = queries[i][2];
        int r2 = r * r;

        for (int j = 0; j < pointsSize; j++) {
            int dx = points[j][0] - x;
            int dy = points[j][1] - y;
            if (dx * dx + dy * dy <= r2) {
                count++;
            }
        }
        result[i] = count;
    }

    return result;
}