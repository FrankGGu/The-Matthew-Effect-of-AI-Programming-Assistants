#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkValidGrid(int** grid, int gridSize, int* gridColSize){
    if (grid[0][0] != 0) {
        return false;
    }

    int x = 0, y = 0;
    int next_x, next_y;

    for (int i = 1; i < gridSize * gridSize; i++) {
        bool found = false;

        // Possible moves:
        int dx[] = {-2, -2, -1, -1, 1, 1, 2, 2};
        int dy[] = {-1, 1, -2, 2, -2, 2, -1, 1};

        for (int j = 0; j < 8; j++) {
            next_x = x + dx[j];
            next_y = y + dy[j];

            if (next_x >= 0 && next_x < gridSize && next_y >= 0 && next_y < gridSize && grid[next_x][next_y] == i) {
                x = next_x;
                y = next_y;
                found = true;
                break;
            }
        }

        if (!found) {
            return false;
        }
    }

    return true;
}