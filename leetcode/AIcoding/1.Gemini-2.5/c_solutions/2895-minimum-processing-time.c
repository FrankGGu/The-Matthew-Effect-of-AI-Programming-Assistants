#include <stdlib.h>
#include <limits.h>

int compareAsc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int compareDesc(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int minProcessingTime(int* processorTime, int processorTimeSize, int* tasks, int tasksSize) {
    qsort(processorTime, processorTimeSize, sizeof(int), compareAsc);
    qsort(tasks, tasksSize, sizeof(int), compareDesc);

    int maxFinishTime = 0;
    int tasksPerProcessor = 4;

    for (int i = 0; i < processorTimeSize; i++) {
        int currentProcessorBaseTime = processorTime[i];
        int largestTaskForThisProcessor = tasks[i * tasksPerProcessor];
        int currentProcessorFinishTime = currentProcessorBaseTime + largestTaskForThisProcessor;

        if (currentProcessorFinishTime > maxFinishTime) {
            maxFinishTime = currentProcessorFinishTime;
        }
    }

    return maxFinishTime;
}