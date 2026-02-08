/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* solveQueries(int* nums, int numsSize, int* queries, int queriesSize, int* returnSize) {
    *returnSize = queriesSize;
    int* result = (int*)malloc(queriesSize * sizeof(int));
    if (result == NULL) return NULL;

    for (int i = 0; i < queriesSize; i++) {
        int queryIndex = queries[i];
        int target = nums[queryIndex];
        int minDistance = -1;

        for (int j = 0; j < numsSize; j++) {
            if (j != queryIndex && nums[j] == target) {
                int distance = abs(j - queryIndex);
                if (minDistance == -1 || distance < minDistance) {
                    minDistance = distance;
                }
            }
        }

        result[i] = minDistance;
    }

    return result;
}