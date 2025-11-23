#include <stdlib.h>
#include <stdbool.h>

bool canFinish(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize) {
    if (numCourses <= 0) {
        return true;
    }
    if (prerequisitesSize == 0) {
        return true;
    }

    int* inDegree = (int*)calloc(numCourses, sizeof(int));
    if (!inDegree) {
        return false;
    }

    int* adj_sizes = (int*)calloc(numCourses, sizeof(int));
    if (!adj_sizes) {
        free(inDegree);
        return false;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int prereq_course = prerequisites[i][1];
        adj_sizes[prereq_course]++;
    }

    int** adj = (int**)malloc(numCourses * sizeof(int*));
    if (!adj) {
        free(inDegree);
        free(adj_sizes);
        return false;
    }

    for (int i = 0; i < numCourses; i++) {
        adj[i] = (int*)malloc(adj_sizes[i] * sizeof(int));
        if (!adj[i] && adj_sizes[i] > 0) {
            for (int j = 0; j < i; j++) {
                free(adj[j]);
            }
            free(adj);
            free(inDegree);
            free(adj_sizes);
            return false;
        }
    }

    int* current_adj_indices = (int*)calloc(numCourses, sizeof(int));
    if (!current_adj_indices) {
        for (int i = 0; i < numCourses; i++) {
            free(adj[i]);
        }
        free(adj);
        free(inDegree);
        free(adj_sizes);
        return false;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int course_to_take = prerequisites[i][0];
        int prereq_course = prerequisites[i][1];

        adj[prereq_course][current_adj_indices[prereq_course]++] = course_to_take;
        inDegree[course_to_take]++;
    }

    free(current_adj_indices);

    int* queue = (int*)malloc(numCourses * sizeof(int));
    if (!queue) {
        for (int i = 0; i < numCourses; i++) {
            free(adj[i]);
        }
        free(adj);
        free(inDegree);
        free(adj_sizes);
        return false;
    }
    int head = 0, tail = 0;

    for (int i = 0; i < numCourses; i++) {
        if (inDegree[i] == 0) {
            queue[tail++] = i;
        }
    }

    int coursesTaken = 0;
    while (head < tail) {
        int u = queue[head++];
        coursesTaken++;

        for (int i = 0; i < adj_sizes[u]; i++) {
            int v = adj[u][i];
            inDegree[v]--;
            if (inDegree[v] == 0) {
                queue[tail++] = v;
            }
        }
    }

    for (int i = 0; i < numCourses; i++) {
        free(adj[i]);
    }
    free(adj);
    free(inDegree);
    free(adj_sizes);
    free(queue);

    return coursesTaken == numCourses;
}