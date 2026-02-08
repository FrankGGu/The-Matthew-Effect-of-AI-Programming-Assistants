#include <stdio.h>
#include <stdlib.h>

typedef struct Edge {
    int to;
    int direction;
    struct Edge* next;
} Edge;

typedef struct {
    Edge* head;
} AdjList;

void addEdge(AdjList* adj, int from, int to, int direction) {
    Edge* newEdge = (Edge*)malloc(sizeof(Edge));
    newEdge->to = to;
    newEdge->direction = direction;
    newEdge->next = adj[from].head;
    adj[from].head = newEdge;
}

int minReorder(int n, int** connections, int connectionsSize, int* connectionsColSize) {
    AdjList adj[n];
    for (int i = 0; i < n; i++) {
        adj[i].head = NULL;
    }

    for (int i = 0; i < connectionsSize; i++) {
        int from = connections[i][0];
        int to = connections[i][1];
        addEdge(adj, from, to, 1);
        addEdge(adj, to, from, -1);
    }

    int visited[n];
    for (int i = 0; i < n; i++) {
        visited[i] = 0;
    }

    int queue[n];
    int front = 0, rear = 0;
    queue[rear++] = 0;
    visited[0] = 1;

    int count = 0;

    while (front < rear) {
        int current = queue[front++];
        Edge* edge = adj[current].head;
        while (edge) {
            if (!visited[edge->to]) {
                if (edge->direction == 1) {
                    count++;
                }
                visited[edge->to] = 1;
                queue[rear++] = edge->to;
            }
            edge = edge->next;
        }
    }

    return count;
}