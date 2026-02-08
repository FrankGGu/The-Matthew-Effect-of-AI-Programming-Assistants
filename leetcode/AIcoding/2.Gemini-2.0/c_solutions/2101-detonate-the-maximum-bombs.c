#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int detonate(int** bombs, int bombsSize, int* bombsColSize, int start, bool* visited) {
    visited[start] = true;
    int count = 1;
    for (int i = 0; i < bombsSize; i++) {
        if (!visited[i]) {
            long long x1 = bombs[start][0];
            long long y1 = bombs[start][1];
            long long r1 = bombs[start][2];
            long long x2 = bombs[i][0];
            long long y2 = bombs[i][1];

            long long dx = x1 - x2;
            long long dy = y1 - y2;

            if (dx * dx + dy * dy <= r1 * r1) {
                count += detonate(bombs, bombsSize, bombsColSize, i, visited);
            }
        }
    }
    return count;
}

int maximumDetonation(int** bombs, int bombsSize, int* bombsColSize) {
    int maxBombs = 0;
    for (int i = 0; i < bombsSize; i++) {
        bool visited[bombsSize];
        for (int j = 0; j < bombsSize; j++) {
            visited[j] = false;
        }
        int detonatedBombs = detonate(bombs, bombsSize, bombsColSize, i, visited);
        if (detonatedBombs > maxBombs) {
            maxBombs = detonatedBombs;
        }
    }
    return maxBombs;
}