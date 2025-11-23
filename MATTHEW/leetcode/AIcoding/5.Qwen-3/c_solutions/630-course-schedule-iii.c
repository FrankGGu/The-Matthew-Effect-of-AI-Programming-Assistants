#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int duration;
} Course;

int compare(const void* a, const void* b) {
    return ((Course*)a)->start - ((Course*)b)->start;
}

int scheduleCourse(int** courses, int coursesSize, int* coursesColSize) {
    qsort(courses, coursesSize, sizeof(Course), compare);

    int* durations = (int*)malloc(coursesSize * sizeof(int));
    int count = 0;
    int total_time = 0;

    for (int i = 0; i < coursesSize; i++) {
        int start = courses[i][0];
        int duration = courses[i][1];

        if (total_time + duration <= start) {
            durations[count++] = duration;
            total_time += duration;
        } else {
            int min_index = 0;
            for (int j = 1; j < count; j++) {
                if (durations[j] < durations[min_index]) {
                    min_index = j;
                }
            }
            if (durations[min_index] > duration) {
                total_time -= durations[min_index];
                total_time += duration;
                durations[min_index] = duration;
            }
        }
    }

    free(durations);
    return count;
}