#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (int*)malloc(sizeof(int) * 10);
    q->size = 0;
    q->capacity = 10;
    return q;
}

void enqueue(Queue* q, int value) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (int*)realloc(q->data, sizeof(int) * q->capacity);
    }
    q->data[q->size++] = value;
}

int dequeue(Queue* q) {
    int val = q->data[0];
    for (int i = 1; i < q->size; i++) {
        q->data[i - 1] = q->data[i];
    }
    q->size--;
    return val;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

bool canTakeCourse(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int course, int target) {
    bool* visited = (bool*)calloc(numCourses, sizeof(bool));
    Queue* q = createQueue();
    enqueue(q, course);
    visited[course] = true;

    while (!isEmpty(q)) {
        int current = dequeue(q);
        if (current == target) {
            free(visited);
            freeQueue(q);
            return true;
        }
        for (int i = 0; i < prerequisitesSize; i++) {
            if (prerequisites[i][1] == current && !visited[prerequisites[i][0]]) {
                visited[prerequisites[i][0]] = true;
                enqueue(q, prerequisites[i][0]);
            }
        }
    }

    free(visited);
    freeQueue(q);
    return false;
}

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    int* result = (int*)malloc(numCourses * sizeof(int));
    int index = 0;
    bool* visited = (bool*)calloc(numCourses, sizeof(bool));
    bool* inStack = (bool*)calloc(numCourses, sizeof(bool));
    bool hasCycle = false;

    int* indegree = (int*)calloc(numCourses, sizeof(int));
    int** graph = (int**)malloc(numCourses * sizeof(int*));
    for (int i = 0; i < numCourses; i++) {
        graph[i] = (int*)malloc(numCourses * sizeof(int));
        for (int j = 0; j < numCourses; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][1];
        int v = prerequisites[i][0];
        graph[u][v] = 1;
        indegree[v]++;
    }

    Queue* q = createQueue();
    for (int i = 0; i < numCourses; i++) {
        if (indegree[i] == 0) {
            enqueue(q, i);
        }
    }

    while (!isEmpty(q)) {
        int current = dequeue(q);
        result[index++] = current;
        for (int i = 0; i < numCourses; i++) {
            if (graph[current][i] == 1) {
                indegree[i]--;
                if (indegree[i] == 0) {
                    enqueue(q, i);
                }
            }
        }
    }

    if (index != numCourses) {
        *returnSize = 0;
        free(result);
        free(indegree);
        for (int i = 0; i < numCourses; i++) {
            free(graph[i]);
        }
        free(graph);
        free(visited);
        free(inStack);
        return NULL;
    }

    *returnSize = numCourses;
    for (int i = 0; i < numCourses; i++) {
        free(graph[i]);
    }
    free(graph);
    free(indegree);
    free(visited);
    free(inStack);
    return result;
}

bool** buildGraph(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize) {
    bool** graph = (bool**)malloc(numCourses * sizeof(bool*));
    for (int i = 0; i < numCourses; i++) {
        graph[i] = (bool*)calloc(numCourses, sizeof(bool));
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][1];
        int v = prerequisites[i][0];
        graph[u][v] = true;
    }

    return graph;
}

void freeGraph(bool** graph, int numCourses) {
    for (int i = 0; i < numCourses; i++) {
        free(graph[i]);
    }
    free(graph);
}

bool canFinish(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize) {
    int* indegree = (int*)calloc(numCourses, sizeof(int));
    int** graph = (int**)malloc(numCourses * sizeof(int*));
    for (int i = 0; i < numCourses; i++) {
        graph[i] = (int*)calloc(numCourses, sizeof(int));
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int u = prerequisites[i][1];
        int v = prerequisites[i][0];
        graph[u][v] = 1;
        indegree[v]++;
    }

    Queue* q = createQueue();
    for (int i = 0; i < numCourses; i++) {
        if (indegree[i] == 0) {
            enqueue(q, i);
        }
    }

    int count = 0;
    while (!isEmpty(q)) {
        int current = dequeue(q);
        count++;
        for (int i = 0; i < numCourses; i++) {
            if (graph[current][i] == 1) {
                indegree[i]--;
                if (indegree[i] == 0) {
                    enqueue(q, i);
                }
            }
        }
    }

    free(indegree);
    for (int i = 0; i < numCourses; i++) {
        free(graph[i]);
    }
    free(graph);
    freeQueue(q);
    return count == numCourses;
}

bool* checkIfPrerequisite(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    bool** graph = buildGraph(numCourses, prerequisites, prerequisitesSize, prerequisitesColSize);
    bool* result = (bool*)malloc(queriesSize * sizeof(bool));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int course = queries[i][0];
        int target = queries[i][1];
        bool* visited = (bool*)calloc(numCourses, sizeof(bool));
        Queue* q = createQueue();
        enqueue(q, course);
        visited[course] = true;
        bool found = false;

        while (!isEmpty(q)) {
            int current = dequeue(q);
            if (current == target) {
                found = true;
                break;
            }
            for (int j = 0; j < numCourses; j++) {
                if (graph[current][j] && !visited[j]) {
                    visited[j] = true;
                    enqueue(q, j);
                }
            }
        }

        result[i] = found;
        free(visited);
        freeQueue(q);
    }

    freeGraph(graph, numCourses);
    return result;
}