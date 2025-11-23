#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MIN(a, b) ((a) < (b) ? (a) : (b))

typedef struct {
    int row;
    int col;
    int cost;
} Node;

int minCost(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize;
    int cols = gridColSize[0];

    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    dist[0][0] = 0;

    Node queue[rows * cols * 4];
    int head = 0, tail = 0;

    queue[tail].row = 0;
    queue[tail].col = 0;
    queue[tail].cost = 0;
    tail++;

    int dr[] = {0, 0, 1, -1};
    int dc[] = {1, -1, 0, 0};

    while (head < tail) {
        Node curr = queue[head++];
        int r = curr.row;
        int c = curr.col;
        int cost = curr.cost;

        if (cost > dist[r][c]) continue;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                int newCost = cost + (grid[r][c] != (i + 1));

                if (newCost < dist[nr][nc]) {
                    dist[nr][nc] = newCost;
                    if(grid[r][c] == (i+1)){
                        Node temp = queue[head-1];
                        queue[head-1] = (Node){nr, nc, newCost};
                        queue[head] = temp;
                        head--;
                    } else {
                         queue[tail].row = nr;
                         queue[tail].col = nc;
                         queue[tail].cost = newCost;
                         tail++;
                    }
                }
            }
        }
    }

    int result = dist[rows - 1][cols - 1];

    for (int i = 0; i < rows; i++) {
        free(dist[i]);
    }
    free(dist);

    return result;
}