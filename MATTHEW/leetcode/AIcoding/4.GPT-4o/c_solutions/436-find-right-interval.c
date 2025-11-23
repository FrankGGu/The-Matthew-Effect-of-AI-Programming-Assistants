#define MAX_INTERVALS 20000

int* findRightInterval(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * intervalsSize);
    int* startIndices = (int*)malloc(sizeof(int) * intervalsSize);
    for (int i = 0; i < intervalsSize; i++) {
        startIndices[i] = i;
    }

    qsort(startIndices, intervalsSize, sizeof(int), 
          [](const void* a, const void* b) {
              return intervals[*(int*)a][0] - intervals[*(int*)b][0];
          });

    for (int i = 0; i < intervalsSize; i++) {
        int target = intervals[i][1];
        int left = 0, right = intervalsSize;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (intervals[startIndices[mid]][0] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        result[i] = (left < intervalsSize) ? startIndices[left] : -1;
    }

    free(startIndices);
    *returnSize = intervalsSize;
    return result;
}