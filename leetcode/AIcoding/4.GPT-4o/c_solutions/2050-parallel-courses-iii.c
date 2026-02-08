#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *prerequisites;
    int size;
} Course;

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int minNumberOfSemesters(int n, int** relations, int relationsSize, int* relationsColSize, int k) {
    int *inDegree = (int *)calloc(n + 1, sizeof(int));
    Course *courses = (Course *)calloc(n + 1, sizeof(Course));
    for (int i = 0; i < relationsSize; i++) {
        int a = relations[i][0], b = relations[i][1];
        inDegree[b]++;
        courses[a].prerequisites = realloc(courses[a].prerequisites, (courses[a].size + 1) * sizeof(int));
        courses[a].prerequisites[courses[a].size++] = b;
    }

    int semesters = 0;
    while (1) {
        int count = 0;
        int *toTake = (int *)calloc(n + 1, sizeof(int));

        for (int j = 1; j <= n; j++) {
            if (inDegree[j] == 0) {
                toTake[count++] = j;
                inDegree[j] = -1; // mark as taken
            }
        }

        if (count == 0) break;
        qsort(toTake, count, sizeof(int), cmp);

        int canTake = count < k ? count : k;
        for (int j = 0; j < canTake; j++) {
            for (int l = 0; l < courses[toTake[j]].size; l++) {
                inDegree[courses[toTake[j]].prerequisites[l]]--;
            }
        }

        semesters++;
        free(toTake);
    }

    free(inDegree);
    for (int i = 1; i <= n; i++) {
        free(courses[i].prerequisites);
    }
    free(courses);

    return semesters;
}