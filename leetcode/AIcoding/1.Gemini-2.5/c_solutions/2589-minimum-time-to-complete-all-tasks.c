#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define MAX_TIME_POINT 2000
static bool cpu_used[MAX_TIME_POINT + 1];

int compareTasks(const void *a, const void *b) {
    const int *taskA = *(const int **)a;
    const int *taskB = *(const int **)b;

    if (taskA[1] != taskB[1]) {
        return taskA[1] - taskB[1];
    }
    return taskA[0] - taskB[0];
}

int minimumTime(int** tasks, int tasksSize, int* tasksColSize) {
    memset(cpu_used, 0, sizeof(cpu_used));

    qsort(tasks, tasksSize, sizeof(int*), compareTasks);

    int total_cpu_time = 0;

    for (int i = 0; i < tasksSize; ++i) {
        int start = tasks[i][0];
        int end = tasks[i][1];
        int duration = tasks[i][2];

        int covered_duration = 0;
        for (int t = start; t <= end; ++t) {
            if (cpu_used[t]) {
                covered_duration++;
            }
        }

        int needed = duration - covered_duration;

        if (needed > 0) {
            for (int t = end; t >= start && needed > 0; --t) {
                if (!cpu_used[t]) {
                    cpu_used[t] = true;
                    total_cpu_time++;
                    needed--;
                }
            }
        }
    }

    return total_cpu_time;
}