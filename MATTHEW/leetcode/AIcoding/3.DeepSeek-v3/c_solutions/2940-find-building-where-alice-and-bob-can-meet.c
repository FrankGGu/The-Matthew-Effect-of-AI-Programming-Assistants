/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* leftmostBuildingQueries(int* heights, int heightsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int a = queries[i][0];
        int b = queries[i][1];

        if (a > b) {
            int temp = a;
            a = b;
            b = temp;
        }

        if (a == b) {
            result[i] = a;
            continue;
        }

        if (heights[a] < heights[b]) {
            result[i] = b;
            continue;
        }

        int found = -1;
        for (int j = b + 1; j < heightsSize; j++) {
            if (heights[j] > heights[a] && heights[j] > heights[b]) {
                found = j;
                break;
            }
        }

        result[i] = found;
    }

    return result;
}