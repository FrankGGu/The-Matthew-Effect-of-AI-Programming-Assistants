#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canFinish(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize) {
    int* inDegree = (int*)calloc(numCourses, sizeof(int));
    int** adjList = (int**)malloc(numCourses * sizeof(int*));
    int* adjSize = (int*)calloc(numCourses, sizeof(int));

    for (int i = 0; i < numCourses; i++) {
        adjList[i] = (int*)malloc(numCourses * sizeof(int));
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int pre = prerequisites[i][1];
        inDegree[course]++;
        adjList[pre][adjSize[pre]++] = course;
    }

    int count = 0;
    int* queue = (int*)malloc(numCourses * sizeof(int));
    int head = 0, tail = 0;

    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    while (head < tail) {
        int course = queue[head++];
        count++;

        for (int i = 0; i < adjSize[course]; i++) {
            int nextCourse = adjList[course][i];
            if (--inDegree[nextCourse] == 0) {
                queue[tail++] = nextCourse;
            }
        }
    }

    for (int i = 0; i < numCourses; i++) {
        free(adjList[i]);
    }
    free(adjList);
    free(inDegree);
    free(queue);

    return count == numCourses;
}