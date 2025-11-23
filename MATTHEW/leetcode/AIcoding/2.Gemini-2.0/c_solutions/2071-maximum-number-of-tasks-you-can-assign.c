#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int check(int mid, int* tasks, int tasksSize, int* workers, int workersSize, int pills, int strength) {
    int i = mid - 1, j = workersSize - 1;
    int currentPills = pills;
    int* tempTasks = (int*)malloc(sizeof(int) * mid);
    for (int k = 0; k < mid; k++) {
        tempTasks[k] = tasks[k];
    }
    qsort(tempTasks, mid, sizeof(int), cmp);

    while (i >= 0) {
        if (workers[j] >= tempTasks[i]) {
            i--;
            j--;
        } else if (currentPills > 0 && workers[j] + strength >= tempTasks[i]) {
            currentPills--;
            i--;
            j--;
        } else {
            free(tempTasks);
            return 0;
        }
    }
    free(tempTasks);
    return 1;
}

int maxTaskAssign(int* tasks, int tasksSize, int* workers, int workersSize, int pills, int strength) {
    qsort(tasks, tasksSize, sizeof(int), cmp);
    qsort(workers, workersSize, sizeof(int), cmp);

    int left = 0, right = (tasksSize < workersSize ? tasksSize : workersSize);
    int result = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(mid, tasks, tasksSize, workers, workersSize, pills, strength)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}