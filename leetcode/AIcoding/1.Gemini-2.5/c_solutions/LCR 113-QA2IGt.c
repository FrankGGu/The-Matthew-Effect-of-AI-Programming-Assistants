#include <stdlib.h> // For malloc, calloc, free
#include <stdbool.h> // For bool type

typedef struct AdjNode {
    int val;
    struct AdjNode *next;
} AdjNode;

void addEdge(AdjNode **adj, int u, int v) {
    AdjNode *newNode = (AdjNode *)malloc(sizeof(AdjNode));
    if (newNode == NULL) {
        return; 
    }
    newNode->val = v;
    newNode->next = adj[u];
    adj[u] = newNode;
}

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    *returnSize = 0;

    AdjNode** adj = (AdjNode**)calloc(numCourses, sizeof(AdjNode*));
    int* in_degree = (int*)calloc(numCourses, sizeof(int));

    if (!adj || !in_degree) {
        if (adj) {
            for (int i = 0; i < numCourses; i++) {
                AdjNode* current = adj[i];
                while (current != NULL) {
                    AdjNode* temp = current;
                    current = current->next;
                    free(temp);
                }
            }
            free(adj);
        }
        if (in_degree) free(in_degree);
        return NULL;
    }

    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int prereq = prerequisites[i][1];
        addEdge(adj, prereq, course);
        in_degree[course]++;
    }

    int* queue = (int*)malloc(numCourses * sizeof(int));
    if (!queue) {
        for (int i = 0; i < numCourses; i++) {
            AdjNode* current = adj[i];
            while (current != NULL) {
                AdjNode* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(adj);
        free(in_degree);
        return NULL;
    }

    int front = 0;
    int rear = 0;

    for (int i = 0; i < numCourses; i++) {
        if (in_degree[i] == 0) {
            queue[rear++] = i;
        }
    }

    int* result = (int*)malloc(numCourses * sizeof(int));
    if (!result) {
        free(queue);
        for (int i = 0; i < numCourses; i++) {
            AdjNode* current = adj[i];
            while (current != NULL) {
                AdjNode* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(adj);
        free(in_degree);
        return NULL;
    }

    int result_idx = 0;

    while (front < rear) {
        int u = queue[front++];
        result[result_idx++] = u;

        AdjNode* current = adj[u];
        while (current != NULL) {
            int v = current->val;
            in_degree[v]--;
            if (in_degree[v] == 0) {
                queue[rear++] = v;
            }
            current = current->next;
        }
    }

    if (result_idx == numCourses) {
        *returnSize = numCourses;
        free(queue);
        for (int i = 0; i < numCourses; i++) {
            AdjNode* current = adj[i];
            while (current != NULL) {
                AdjNode* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(adj);
        free(in_degree);
        return result;
    } else {
        free(result);
        free(queue);
        for (int i = 0; i < numCourses; i++) {
            AdjNode* current = adj[i];
            while (current != NULL) {
                AdjNode* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(adj);
        free(in_degree);
        return NULL;
    }
}