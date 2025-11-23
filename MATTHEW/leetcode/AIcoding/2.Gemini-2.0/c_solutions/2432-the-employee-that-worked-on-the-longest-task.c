#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int hardestWorker(int n, int** logs, int logsSize, int* logsColSize) {
    int max_duration = logs[0][1];
    int employee_id = logs[0][0];
    for (int i = 1; i < logsSize; i++) {
        int duration = logs[i][1] - logs[i - 1][1];
        if (i == 0) {
            duration = logs[i][1];
        } else {
            duration = logs[i][1] - logs[i - 1][1];
        }

        if (duration > max_duration) {
            max_duration = duration;
            employee_id = logs[i][0];
        } else if (duration == max_duration) {
            if (logs[i][0] < employee_id) {
                employee_id = logs[i][0];
            }
        }
    }
    return employee_id;
}