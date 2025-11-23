#include <stdlib.h>
#include <string.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

typedef struct {
    int node;
    int color; // 0 for red, 1 for blue
    struct Node* next;
} Node;

int* shortestAlternatingPaths(int n, int** redEdges, int redEdgesSize, int* redEdgesColSize, int** blueEdges, int blueEdgesSize, int* blueEdgesColSize, int* returnSize) {
    Node** redGraph = (Node**)calloc(n, sizeof(Node*));
    Node** blueGraph = (Node**)calloc(n, sizeof(Node*));

    for (int i = 0; i < redEdgesSize; i++) {
        int u = redEdges[i][0];
        int v = redEdges[i][1];
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->node = v;
        newNode->color = 0;
        newNode->next = redGraph[u];
        redGraph[u] = newNode;
    }

    for (int i = 0; i < blueEdgesSize; i++) {
        int u = blueEdges[i][0];
        int v = blueEdges[i][1];
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->node = v;
        newNode->color = 1;
        newNode->next = blueGraph[u];
        blueGraph[u] = newNode;
    }

    int* res = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        res[i] = -1;
    }

    int** visited = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        visited[i] = (int*)malloc(2 * sizeof(int));
        visited[i][0] = 0;
        visited[i][1] = 0;
    }

    int** queue = (int**)malloc(2 * n * sizeof(int*));
    for (int i = 0; i < 2 * n; i++) {
        queue[i] = (int*)malloc(2 * sizeof(int));
    }

    int front = 0, rear = 0;

    queue[rear][0] = 0;
    queue[rear][1] = 0;
    rear++;
    queue[rear][0] = 0;
    queue[rear][1] = 1;
    rear++;

    visited[0][0] = 1;
    visited[0][1] = 1;
    res[0] = 0;

    int steps = 0;

    while (front < rear) {
        int size = rear - front;
        steps++;

        for (int i = 0; i < size; i++) {
            int currNode = queue[front][0];
            int currColor = queue[front][1];
            front++;

            if (currColor == 0) {
                Node* neighbor = blueGraph[currNode];
                while (neighbor != NULL) {
                    int nextNode = neighbor->node;
                    if (!visited[nextNode][1]) {
                        visited[nextNode][1] = 1;
                        if (res[nextNode] == -1) {
                            res[nextNode] = steps;
                        }
                        queue[rear][0] = nextNode;
                        queue[rear][1] = 1;
                        rear++;
                    }
                    neighbor = neighbor->next;
                }
            } else {
                Node* neighbor = redGraph[currNode];
                while (neighbor != NULL) {
                    int nextNode = neighbor->node;
                    if (!visited[nextNode][0]) {
                        visited[nextNode][0] = 1;
                        if (res[nextNode] == -1) {
                            res[nextNode] = steps;
                        }
                        queue[rear][0] = nextNode;
                        queue[rear][1] = 0;
                        rear++;
                    }
                    neighbor = neighbor->next;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(visited[i]);
    }
    free(visited);

    for (int i = 0; i < n; i++) {
        Node* curr = redGraph[i];
        while (curr != NULL) {
            Node* temp = curr;
            curr = curr->next;
            free(temp);
        }
        curr = blueGraph[i];
        while (curr != NULL) {
            Node* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }
    free(redGraph);
    free(blueGraph);

    for (int i = 0; i < 2 * n; i++) {
        free(queue[i]);
    }
    free(queue);

    *returnSize = n;
    return res;
}