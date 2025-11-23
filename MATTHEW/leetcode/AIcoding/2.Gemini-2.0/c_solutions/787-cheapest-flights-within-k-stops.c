#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int city;
    int cost;
    int stops;
} QueueNode;

int findCheapestPrice(int n, int** flights, int flightsSize, int* flightsColSize, int src, int dst, int k) {
    int* minCost = (int*)malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        minCost[i] = INT_MAX;
    }
    minCost[src] = 0;

    QueueNode* queue = (QueueNode*)malloc(sizeof(QueueNode) * (n * (k + 2)));
    int front = 0, rear = 0;
    queue[rear].city = src;
    queue[rear].cost = 0;
    queue[rear].stops = -1;
    rear++;

    while (front < rear) {
        QueueNode curr = queue[front++];
        int city = curr.city;
        int cost = curr.cost;
        int stops = curr.stops;

        if (stops > k) continue;

        for (int i = 0; i < flightsSize; i++) {
            if (flights[i][0] == city) {
                int nextCity = flights[i][1];
                int nextCost = cost + flights[i][2];
                if (nextCost < minCost[nextCity]) {
                    minCost[nextCity] = nextCost;
                    queue[rear].city = nextCity;
                    queue[rear].cost = nextCost;
                    queue[rear].stops = stops + 1;
                    rear++;
                }
            }
        }
    }

    int result = minCost[dst];
    free(minCost);
    free(queue);

    return (result == INT_MAX) ? -1 : result;
}