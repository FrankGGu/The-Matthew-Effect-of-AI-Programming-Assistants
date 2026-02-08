#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int pass;
    int total;
    double diff;
} Class;

int compare(const void *a, const void *b) {
    Class *classA = (Class *)a;
    Class *classB = (Class *)b;
    if (classA->diff < classB->diff) return 1;
    if (classA->diff > classB->diff) return -1;
    return 0;
}

double maxAverageRatio(int** classes, int classesSize, int* classesColSize, int extraStudents) {
    Class arr[classesSize];
    for (int i = 0; i < classesSize; i++) {
        arr[i].pass = classes[i][0];
        arr[i].total = classes[i][1];
        arr[i].diff = (double)(arr[i].pass + 1) / (arr[i].total + 1) - (double)arr[i].pass / arr[i].total;
    }

    qsort(arr, classesSize, sizeof(Class), compare);

    for (int i = 0; i < extraStudents; i++) {
        arr[0].pass++;
        arr[0].total++;
        arr[0].diff = (double)(arr[0].pass + 1) / (arr[0].total + 1) - (double)arr[0].pass / arr[0].total;
        qsort(arr, classesSize, sizeof(Class), compare);
    }

    double sum = 0.0;
    for (int i = 0; i < classesSize; i++) {
        sum += (double)arr[i].pass / arr[i].total;
    }

    return sum / classesSize;
}