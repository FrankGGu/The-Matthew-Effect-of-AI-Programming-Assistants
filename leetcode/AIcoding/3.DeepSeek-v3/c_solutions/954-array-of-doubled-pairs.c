#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    int x = *(int*)a;
    int y = *(int*)b;
    if (x < 0 && y < 0) {
        return y - x;
    }
    return x - y;
}

int canReorderDoubled(int* arr, int arrSize) {
    qsort(arr, arrSize, sizeof(int), cmp);

    int* used = (int*)calloc(arrSize, sizeof(int));
    if (!used) return 0;

    int left = 0;
    for (int i = 0; i < arrSize; i++) {
        if (used[i]) continue;

        int target = 2 * arr[i];
        int found = 0;

        for (int j = i + 1; j < arrSize; j++) {
            if (!used[j] && arr[j] == target) {
                used[j] = 1;
                found = 1;
                break;
            }
        }

        if (!found) {
            free(used);
            return 0;
        }

        used[i] = 1;
    }

    free(used);
    return 1;
}