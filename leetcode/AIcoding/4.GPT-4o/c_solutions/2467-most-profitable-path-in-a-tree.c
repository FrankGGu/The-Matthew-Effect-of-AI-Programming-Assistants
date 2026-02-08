#include <stdio.h>
#include <stdlib.h>

#define MAX 100005

typedef struct {
    int* arr;
    int front;
    int rear;
} Queue;

Queue* createQueue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->arr = (int*)malloc(sizeof(int) * MAX);
    q->front = 0;
    q->rear = 0;
    return q;
}

void enqueue(Queue* q, int value) {
    q->arr[q->rear++] = value;
}

int dequeue(Queue* q) {
    return q->arr[q->front++];
}

int isEmpty(Queue* q) {
    return q->front == q->rear;
}

typedef struct {
    int node;
    int profit;
} Node;

int mostProfitablePath(int** edges, int edgesSize, int* edgesColSize, int* prices, int n, int bob, int target) {
    int graph[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            graph[i][j] = -1;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]][edges[i][1]] = edges[i][1];
        graph[edges[i][1]][edges[i][0]] = edges[i][0];
    }

    int profits[n];
    for (int i = 0; i < n; i++) {
        profits[i] = prices[i];
    }

    int dist[n];
    for (int i = 0; i < n; i++) {
        dist[i] = -1;
    }
    dist[bob] = 0;

    Queue* q = createQueue();
    enqueue(q, bob);

    while (!isEmpty(q)) {
        int curr = dequeue(q);
        for (int i = 0; i < n; i++) {
            if (graph[curr][i] != -1 && dist[i] == -1) {
                dist[i] = dist[curr] + 1;
                enqueue(q, i);
            }
        }
    }

    int minDist = dist[target];
    int totalProfit = 0;
    for (int i = 0; i < n; i++) {
        if (dist[i] != -1 && dist[i] <= minDist) {
            totalProfit += profits[i];
        }
    }

    return totalProfit;
}