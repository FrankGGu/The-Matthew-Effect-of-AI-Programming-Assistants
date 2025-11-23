#include <stdlib.h>
#include <string.h>

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    int* inDegree = (int*)calloc(numCourses, sizeof(int));
    int** graph = (int**)malloc(numCourses * sizeof(int*));
    for (int i = 0; i < numCourses; i++) {
        graph[i] = (int*)malloc(numCourses * sizeof(int));
    }
    int* graphSize = (int*)calloc(numCourses, sizeof(int));

    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int prereq = prerequisites[i][1];
        graph[prereq][graphSize[prereq]++] = course;
        inDegree[course]++;
    }

    int* queue = (int*)malloc(numCourses * sizeof(int));
    int front = 0, rear = 0;

    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int* result = (int*)malloc(numCourses * sizeof(int));
    int count = 0;

    while (front < rear) {
        int current = queue[front++];
        result[count++] = current;

        for (int i = 0; i < graphSize[current]; i++) {
            int neighbor = graph[current][i];
            inDegree[neighbor]--;
            if (inDegree[neighbor] == 0) {
                queue[rear++] = neighbor;
            }
        }
    }

    for (int i = 0; i < numCourses; i++) {
        free(graph[i]);
    }
    free(graph);
    free(graphSize);
    free(inDegree);
    free(queue);

    if (count == numCourses) {
        *returnSize = numCourses;
        return result;
    } else {
        free(result);
        *returnSize = 0;
        return NULL;
    }
}