/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* mostVisited(int n, int* rounds, int roundsSize, int* returnSize) {
    int* result = malloc(n * sizeof(int));
    *returnSize = 0;

    int start = rounds[0];
    int end = rounds[roundsSize - 1];

    if (start <= end) {
        for (int i = start; i <= end; i++) {
            result[(*returnSize)++] = i;
        }
    } else {
        for (int i = 1; i <= end; i++) {
            result[(*returnSize)++] = i;
        }
        for (int i = start; i <= n; i++) {
            result[(*returnSize)++] = i;
        }
    }

    return result;
}