#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    int* aa = *(int**)a;
    int* bb = *(int**)b;
    if (aa[1] == bb[1]) {
        return aa[0] - bb[0];
    }
    return aa[1] - bb[1];
}

int processTasks(int** tasks, int tasksSize, int* tasksColSize) {
    qsort(tasks, tasksSize, sizeof(int*), cmp);

    int res = 0;
    int end = 0;
    for (int i = 0; i < tasksSize; i++) {
        int start = tasks[i][0];
        int stop = tasks[i][1];
        int duration = tasks[i][2];

        if (end >= stop) {
            int overlap = end - start + 1;
            if (overlap < duration) {
                res += duration - overlap;
                end += duration - overlap;
            }
        } else {
            res += duration;
            end = start + duration - 1;
        }
    }

    return res;
}