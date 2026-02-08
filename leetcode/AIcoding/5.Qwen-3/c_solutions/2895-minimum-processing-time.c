#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minProcessingTime(int* processorTime, int processorTimeSize, int* tasks, int tasksSize) {
    qsort(processorTime, processorTimeSize, sizeof(int), compare);
    qsort(tasks, tasksSize, sizeof(int), compare);

    int max = 0;
    for (int i = 0; i < processorTimeSize; i++) {
        int start = i * 4;
        int end = start + 4;
        int currentMax = 0;
        for (int j = start; j < end && j < tasksSize; j++) {
            if (tasks[j] > currentMax) {
                currentMax = tasks[j];
            }
        }
        if (currentMax + processorTime[i] > max) {
            max = currentMax + processorTime[i];
        }
    }
    return max;
}