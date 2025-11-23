#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point from;
    Point to;
    int cost;
} SpecialRoad;

typedef struct {
    int x;
    int y;
    int cost;
} State;

int compare(const void *a, const void *b) {
    return ((State *)a)->cost - ((State *)b)->cost;
}

int minCost(int** start, int startSize, int** end, int endSize, int** specialRoads, int specialRoadsSize, int* specialRoadsColSize) {
    int dx[] = {0, 1, 0, -1};
    int dy[] = {1, 0, -1, 0};

    int rows = 101;
    int cols = 101;

    int dist[101][101];
    for (int i = 0; i < 101; i++) {
        for (int j = 0; j < 101; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    Point startPt = {start[0][0], start[0][1]};
    Point endPt = {end[0][0], end[0][1]};

    dist[startPt.x][startPt.y] = 0;

    State queue[10000];
    int front = 0, rear = 0;

    queue[rear].x = startPt.x;
    queue[rear].y = startPt.y;
    queue[rear].cost = 0;
    rear++;

    while (front < rear) {
        State current = queue[front];
        front++;

        if (current.x == endPt.x && current.y == endPt.y) {
            return current.cost;
        }

        for (int i = 0; i < 4; i++) {
            int nx = current.x + dx[i];
            int ny = current.y + dy[i];
            if (nx >= 0 && nx < 101 && ny >= 0 && ny < 101) {
                if (dist[nx][ny] > current.cost + 1) {
                    dist[nx][ny] = current.cost + 1;
                    queue[rear].x = nx;
                    queue[rear].y = ny;
                    queue[rear].cost = current.cost + 1;
                    rear++;
                }
            }
        }

        for (int i = 0; i < specialRoadsSize; i++) {
            int sx = specialRoads[i][0];
            int sy = specialRoads[i][1];
            int ex = specialRoads[i][2];
            int ey = specialRoads[i][3];
            int cost = specialRoads[i][4];

            if (current.x == sx && current.y == sy) {
                if (dist[ex][ey] > current.cost + cost) {
                    dist[ex][ey] = current.cost + cost;
                    queue[rear].x = ex;
                    queue[rear].y = ey;
                    queue[rear].cost = current.cost + cost;
                    rear++;
                }
            }
        }
    }

    return dist[endPt.x][endPt.y];
}