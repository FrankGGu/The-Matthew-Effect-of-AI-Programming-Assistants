#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPathCrossing(char *path) {
    int x = 0, y = 0;
    int len = strlen(path);
    int *visited_x = (int *)malloc(sizeof(int) * (len * 2 + 10));
    int *visited_y = (int *)malloc(sizeof(int) * (len * 2 + 10));
    int visited_count = 0;

    visited_x[visited_count] = 0;
    visited_y[visited_count] = 0;
    visited_count++;

    for (int i = 0; i < len; i++) {
        if (path[i] == 'N') {
            y++;
        } else if (path[i] == 'S') {
            y--;
        } else if (path[i] == 'E') {
            x++;
        } else {
            x--;
        }

        for (int j = 0; j < visited_count; j++) {
            if (visited_x[j] == x && visited_y[j] == y) {
                free(visited_x);
                free(visited_y);
                return true;
            }
        }

        visited_x[visited_count] = x;
        visited_y[visited_count] = y;
        visited_count++;
    }

    free(visited_x);
    free(visited_y);
    return false;
}