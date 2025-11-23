typedef struct {
    long key;
    int idx;
    UT_hash_handle hh;
} HashNode;

int cmp(const void *a, const void *b) {
    long *A = (long *)a;
    long *B = (long *)b;
    if (*A > *B) return 1;
    if (*A < *B) return -1;
    return 0;
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int indexDiff, int valueDiff) {
    if (numsSize == 0 || indexDiff <= 0 || valueDiff < 0) return false;

    long *sorted = (long *)malloc(numsSize * sizeof(long));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = (long)nums[i];
    }

    long *window = (long *)malloc((indexDiff + 1) * sizeof(long));

    for (int i = 0; i <= numsSize - 1; i++) {
        int windowSize = (i < indexDiff) ? i + 1 : indexDiff + 1;
        int start = (i - indexDiff < 0) ? 0 : i - indexDiff;

        for (int j = start; j <= i; j++) {
            window[j - start] = sorted[j];
        }

        qsort(window, windowSize, sizeof(long), cmp);

        for (int j = 0; j < windowSize - 1; j++) {
            if (labs(window[j] - window[j + 1]) <= valueDiff) {
                free(sorted);
                free(window);
                return true;
            }
        }
    }

    free(sorted);
    free(window);
    return false;
}