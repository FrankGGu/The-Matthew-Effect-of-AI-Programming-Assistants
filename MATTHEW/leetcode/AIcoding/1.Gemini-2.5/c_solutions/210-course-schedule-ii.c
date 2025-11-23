#include <stdlib.h>

typedef struct Node {
    int val;
    struct Node* next;
} Node;

int* findOrder(int numCourses, int** prerequisites, int prerequisitesSize, int* prerequisitesColSize, int* returnSize) {
    // Allocate memory for in-degrees and initialize to 0
    int* in_degree = (int*)calloc(numCourses, sizeof(int));
    if (!in_degree) {
        *returnSize = 0;
        return NULL;
    }

    // Allocate memory for adjacency list (array of Node pointers) and initialize to NULL
    Node** adj = (Node**)calloc(numCourses, sizeof(Node*));
    if (!adj) {
        free(in_degree);
        *returnSize = 0;
        return NULL;
    }

    // Build graph and calculate in-degrees
    for (int i = 0; i < prerequisitesSize; i++) {
        int course = prerequisites[i][0];
        int prereq = prerequisites[i][1];

        // Add edge prereq -> course
        Node* newNode = (Node*)malloc(sizeof(Node));
        if (!newNode) {
            // Cleanup in case of allocation failure
            free(in_degree);
            for (int j = 0; j < numCourses; j++) {
                Node* current = adj[j];
                while (current) {
                    Node* temp = current;
                    current = current->next;
                    free(temp);
                }
            }
            free(adj);
            *returnSize = 0;
            return NULL;
        }
        newNode->val = course;
        newNode->next = adj[prereq];
        adj[prereq] = newNode;

        in_degree[course]++;
    }

    // Initialize queue for BFS
    int* queue = (int*)malloc(numCourses * sizeof(int));
    if (!queue) {
        free(in_degree);
        for (int i = 0; i < numCourses; i++) {
            Node* current = adj[i];
            while (current) {
                Node* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(adj);
        *returnSize = 0;
        return NULL;
    }
    int front = 0, rear = 0;

    // Add all courses with 0 in-degree to the queue
    for (int i = 0; i < numCourses; i++) {
        if (in_degree[i] == 0) {
            queue[rear++] = i;
        }
    }

    // Allocate memory for the result array
    int* result = (int*)malloc(numCourses * sizeof(int));
    if (!result) {
        free(in_degree);
        free(queue);
        for (int i = 0; i < numCourses; i++) {
            Node* current = adj[i];
            while (current) {
                Node* temp = current;
                current = current->next;
                free(temp);
            }
        }
        free(adj);
        *returnSize = 0;
        return NULL;
    }
    int count = 0;

    // BFS (Kahn's algorithm)
    while (front < rear) {
        int u = queue[front++];
        result[count++] = u;

        Node* current = adj[u];
        while (current) {
            int v = current->val;
            in_degree[v]--;
            if (in_degree[v] == 0) {
                queue[rear++] = v;
            }
            current = current->next;
        }
    }

    // Clean up adjacency list nodes
    for (int i = 0; i < numCourses; i++) {
        Node* current = adj[i];
        while (current) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(adj);
    free(in_degree);
    free(queue);

    // Check if all courses were taken (no cycle)
    if (count == numCourses) {
        *returnSize = numCourses;
        return result;
    } else {
        // Cycle detected or not all courses could be taken
        free(result);
        *returnSize = 0;
        return NULL;
    }
}