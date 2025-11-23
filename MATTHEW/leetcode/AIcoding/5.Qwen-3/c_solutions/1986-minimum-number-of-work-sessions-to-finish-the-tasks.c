#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minSessions(int* tasks, int tasksSize, int sessionTime) {
    qsort(tasks, tasksSize, sizeof(int), compare);

    int result = INT_MAX;
    int* sessions = (int*)malloc(tasksSize * sizeof(int));

    void backtrack(int index, int count) {
        if (index == tasksSize) {
            result = (count < result) ? count : result;
            return;
        }

        for (int i = 0; i < count; i++) {
            if (sessions[i] + tasks[index] <= sessionTime) {
                sessions[i] += tasks[index];
                backtrack(index + 1, count);
                sessions[i] -= tasks[index];
                if (sessions[i] == 0) break;
            }
        }

        if (count < result) {
            sessions[count] = tasks[index];
            backtrack(index + 1, count + 1);
            sessions[count] = 0;
        }
    }

    backtrack(0, 0);
    free(sessions);
    return result;
}