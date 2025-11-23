#include <stdlib.h>

bool canFinish(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize) {
    int* indegree = (int*)calloc(numCourses, sizeof(int));
    int** graph = (int**)malloc(numCourses * sizeof(int*));
    int* graphSize = (int*)calloc(numCourses, sizeof(int));
    int* graphCapacity = (int*)malloc(numCourses * sizeof(int));

    for (int i = 0; i < numCourses; i++) {
        graphCapacity[i] = 10;
        graph[i] = (int*)malloc(graphCapacity[i] * sizeof(int));
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int prereq = prerequisites[i][1];

        indegree[course]++;

        if (graphSize[prereq] >= graphCapacity[prereq]) {
            graphCapacity[prereq] *= 2;
            graph[prereq] = (int*)realloc(graph[prereq], graphCapacity[prereq] * sizeof(int));
        }
        graph[prereq][graphSize[prereq]++] = course;
    }

    int* queue = (int*)malloc(numCourses * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < numCourses; i++) {
        if (indegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int count = 0;
    while (front < rear) {
        int current = queue[front++];
        count++;

        for (int i = 0; i < graphSize[current]; i++) {
            int neighbor = graph[current][i];
            indegree[neighbor]--;
            if (indegree[neighbor] == 0) {
                queue[rear++] = neighbor;
            }
        }
    }

    for (int i = 0; i < numCourses; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(graphCapacity);
    free(indegree);
    free(queue);

    return count == numCourses;
}