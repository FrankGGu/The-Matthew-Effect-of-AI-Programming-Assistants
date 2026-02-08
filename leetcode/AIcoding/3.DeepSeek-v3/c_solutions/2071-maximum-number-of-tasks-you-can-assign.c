#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int maxTaskAssign(int* tasks, int tasksSize, int* workers, int workersSize, int pills, int strength) {
    qsort(tasks, tasksSize, sizeof(int), cmp);
    qsort(workers, workersSize, sizeof(int), cmp);

    int left = 0, right = tasksSize;
    if (tasksSize > workersSize) right = workersSize;

    while (left < right) {
        int mid = left + (right - left + 1) / 2;
        int p = pills;
        int valid = 1;
        int *deque = (int*)malloc(workersSize * sizeof(int));
        int front = 0, rear = 0;
        int j = workersSize - 1;

        for (int i = mid - 1; i >= 0; i--) {
            while (j >= workersSize - mid && workers[j] + strength >= tasks[i]) {
                deque[rear++] = workers[j--];
            }

            if (front == rear) {
                valid = 0;
                break;
            }

            if (deque[front] >= tasks[i]) {
                front++;
            } else {
                if (p == 0) {
                    valid = 0;
                    break;
                }
                p--;
                rear--;
            }
        }

        free(deque);
        if (valid) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}