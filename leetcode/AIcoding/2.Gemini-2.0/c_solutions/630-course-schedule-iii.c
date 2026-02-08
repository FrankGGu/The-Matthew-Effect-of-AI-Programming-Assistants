#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return ((int *)a)[1] - ((int *)b)[1];
}

int cmp2(const void *a, const void *b) {
    return *(int *)b - *(int *)a;
}

int scheduleCourse(int** courses, int coursesSize, int* coursesColSize){
    qsort(courses, coursesSize, sizeof(courses[0]), cmp);

    int *taken = (int*)malloc(coursesSize * sizeof(int));
    int takenSize = 0;
    int time = 0;

    for (int i = 0; i < coursesSize; i++) {
        if (time + courses[i][0] <= courses[i][1]) {
            taken[takenSize++] = courses[i][0];
            time += courses[i][0];
            qsort(taken, takenSize, sizeof(int), cmp2);
        } else if (takenSize > 0 && courses[i][0] < taken[0]) {
            time -= taken[0];
            time += courses[i][0];
            taken[0] = courses[i][0];
            qsort(taken, takenSize, sizeof(int), cmp2);
        }
    }

    free(taken);
    return takenSize;
}