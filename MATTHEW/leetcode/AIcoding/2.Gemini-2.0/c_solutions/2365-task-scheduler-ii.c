#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long scheduleCourse(int* tasks, int tasksSize, int space) {
    long long days = 0;
    long long* last_day = (long long*)malloc(sizeof(long long) * 200001);
    for (int i = 0; i < 200001; i++) {
        last_day[i] = -1;
    }

    for (int i = 0; i < tasksSize; i++) {
        int task = tasks[i];
        if (last_day[task] == -1 || days > last_day[task]) {
            days++;
            last_day[task] = days + space;
        } else {
            days = last_day[task] + 1;
            last_day[task] = days + space;
        }
    }

    free(last_day);
    return days;
}