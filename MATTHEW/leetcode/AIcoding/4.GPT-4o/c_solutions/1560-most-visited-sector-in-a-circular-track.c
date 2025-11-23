int* mostVisited(int n, int* rounds, int roundsSize, int* returnSize) {
    int* count = (int*)calloc(n + 1, sizeof(int));
    for (int i = 0; i < roundsSize - 1; i++) {
        int start = rounds[i];
        int end = rounds[i + 1];
        if (start <= end) {
            for (int j = start; j < end; j++) {
                count[j]++;
            }
        } else {
            for (int j = start; j <= n; j++) {
                count[j]++;
            }
            for (int j = 1; j < end; j++) {
                count[j]++;
            }
        }
    }
    count[rounds[roundsSize - 1]]++;

    int maxCount = 0;
    for (int i = 1; i <= n; i++) {
        if (count[i] > maxCount) {
            maxCount = count[i];
        }
    }

    *returnSize = 0;
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 1; i <= n; i++) {
        if (count[i] == maxCount) {
            result[(*returnSize)++] = i;
        }
    }

    free(count);
    return result;
}