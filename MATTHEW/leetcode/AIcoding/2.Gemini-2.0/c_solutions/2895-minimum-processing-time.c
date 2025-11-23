#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minProcessingTime(int* processorTime, int processorTimeSize, int* tasks, int tasksSize) {
    qsort(processorTime, processorTimeSize, sizeof(int), compare);
    qsort(tasks, tasksSize, sizeof(int), compare);

    int max_time = 0;
    for (int i = 0; i < processorTimeSize; i++) {
        int current_time = processorTime[i] + tasks[tasksSize - 1 - i * 4];
        if (current_time > max_time) {
            max_time = current_time;
        }
    }
    return max_time;
}