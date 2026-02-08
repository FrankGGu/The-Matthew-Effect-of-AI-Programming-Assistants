#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 1000

typedef struct {
    int row;
    int col;
    int dist;
} Node;

int compare(const void *a, const void *b) {
    return ((Node*)a)->dist - ((Node*)b)->dist;
}

int* kthNearestObstacle(int m, int n, int** obstacles, int obstaclesSize, int* obstaclesColSize, int** queries, int queriesSize, int* queriesColSize, int k, int* returnSize){
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int q = 0; q < queriesSize; q++) {
        int queryRow = queries[q][0];
        int queryCol = queries[q][1];

        Node distances[obstaclesSize];
        for (int i = 0; i < obstaclesSize; i++) {
            distances[i].row = obstacles[i][0];
            distances[i].col = obstacles[i][1];
            distances[i].dist = abs(obstacles[i][0] - queryRow) + abs(obstacles[i][1] - queryCol);
        }

        qsort(distances, obstaclesSize, sizeof(Node), compare);

        if (k <= obstaclesSize) {
            result[q] = -1;
            int count = 0;
            for(int i = 0; i < obstaclesSize; i++){
                if(distances[i].dist > 0){
                    result[q] = distances[i].dist;
                    count++;
                }
                if(count == k){
                    break;
                }
            }

            if(count < k){
                result[q] = -1;
            } else {
                result[q] = distances[k - 1].dist;
            }

        } else {
            result[q] = -1;
        }

    }

    return result;
}