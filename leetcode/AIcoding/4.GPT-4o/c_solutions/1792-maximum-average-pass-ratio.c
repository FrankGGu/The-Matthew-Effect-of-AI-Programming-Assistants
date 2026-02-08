#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int passed;
    int total;
} Class;

int cmp(const void *a, const void *b) {
    double diffA = ((double)((Class *)a)->passed + 1) / ((Class *)a)->total - (double)((Class *)a)->passed / ((Class *)a)->total;
    double diffB = ((double)((Class *)b)->passed + 1) / ((Class *)b)->total - (double)((Class *)b)->passed / ((Class *)b)->total;
    return (diffB > diffA) - (diffB < diffA);
}

double maxAverageRatio(int** classes, int classesSize, int extraStudents) {
    Class *classArr = (Class *)malloc(classesSize * sizeof(Class));
    for (int i = 0; i < classesSize; i++) {
        classArr[i].passed = classes[i][0];
        classArr[i].total = classes[i][1];
    }

    qsort(classArr, classesSize, sizeof(Class), cmp);

    for (int i = 0; i < extraStudents; i++) {
        qsort(classArr, classesSize, sizeof(Class), cmp);
        classArr[0].passed++;
        classArr[0].total++;
    }

    double totalAverage = 0.0;
    for (int i = 0; i < classesSize; i++) {
        totalAverage += (double)classArr[i].passed / classArr[i].total;
    }

    free(classArr);
    return totalAverage / classesSize;
}