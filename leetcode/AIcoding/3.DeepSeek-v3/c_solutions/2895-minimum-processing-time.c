#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minProcessingTime(int* processorTime, int processorTimeSize, int* tasks, int tasksSize) {
    qsort(processorTime, processorTimeSize, sizeof(int), compare);
    qsort(tasks, tasksSize, sizeof(int), compare);

    int result = 0;
    int taskIndex = tasksSize - 1;

    for (int i = 0; i < processorTimeSize; i++) {
        int currentMax = 0;
        for (int j = 0; j < 4; j++) {
            int time = processorTime[i] + tasks[taskIndex--];
            if (time > currentMax) {
                currentMax = time;
            }
        }
        if (currentMax > result) {
            result = currentMax;
        }
    }

    return result;
}