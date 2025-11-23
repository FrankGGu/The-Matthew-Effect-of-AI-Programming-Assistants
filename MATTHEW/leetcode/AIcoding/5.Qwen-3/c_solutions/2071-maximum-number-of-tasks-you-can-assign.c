#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxTasks(int* tasks, int tasksSize, int* workers, int workersSize, int coins) {
    qsort(tasks, tasksSize, sizeof(int), compare);
    qsort(workers, workersSize, sizeof(int), compare);

    int left = 0;
    int right = tasksSize;
    int result = 0;

    while (left <= right) {
        int mid = (left + right) / 2;
        int i = 0;
        int j = workersSize - 1;
        int count = 0;
        int temp_coins = coins;

        for (i = tasksSize - 1; i >= 0 && mid > 0; i--) {
            if (j >= 0 && workers[j] >= tasks[i]) {
                count++;
                j--;
                mid--;
            } else {
                temp_coins -= tasks[i];
                if (temp_coins < 0) break;
            }
        }

        if (count + (coins >= 0 ? (coins / tasks[0]) : 0) >= tasksSize - mid) {
            result = tasksSize - mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}