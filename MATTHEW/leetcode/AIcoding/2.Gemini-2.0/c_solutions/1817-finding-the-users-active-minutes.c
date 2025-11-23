#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findingUsersActiveMinutes(int** logs, int logsSize, int* logsColSize, int k, int* returnSize) {
    int* result = (int*)calloc(k, sizeof(int));
    *returnSize = k;

    int* user_minutes = (int*)malloc(100001 * sizeof(int));
    for (int i = 0; i <= 100000; i++) {
        user_minutes[i] = 0;
    }

    for (int i = 0; i < logsSize; i++) {
        int user_id = logs[i][0];
        int minute = logs[i][1];

        if (user_minutes[user_id] == 0) {
            user_minutes[user_id] = 1;
        }
    }

    int* active_minutes = (int*)malloc(100001 * sizeof(int));
    for (int i = 0; i <= 100000; i++) {
        active_minutes[i] = 0;
    }

    for (int i = 0; i < logsSize; i++) {
        int user_id = logs[i][0];
        int minute = logs[i][1];

        int found = 0;
        for (int j = 0; j < i; j++) {
            if (logs[j][0] == user_id && logs[j][1] == minute) {
                found = 1;
                break;
            }
        }

        if (!found) {
            active_minutes[user_id]++;
        }
    }

    for (int i = 1; i <= 100000; i++) {
        if (user_minutes[i] != 0) {
            result[active_minutes[i] - 1]++;
        }
    }

    free(user_minutes);
    free(active_minutes);

    return result;
}