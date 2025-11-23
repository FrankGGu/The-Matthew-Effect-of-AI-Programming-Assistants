#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countLatticePoints(int** circles, int circlesSize, int* circlesColSize) {
    int count = 0;
    bool visited[201][201] = {false};

    for (int i = 0; i < circlesSize; i++) {
        int x = circles[i][0];
        int y = circles[i][1];
        int r = circles[i][2];

        for (int j = x - r; j <= x + r; j++) {
            for (int k = y - r; k <= y + r; k++) {
                if (j >= 0 && j <= 200 && k >= 0 && k <= 200) {
                    double dist = sqrt(pow(j - x, 2) + pow(k - y, 2));
                    if (dist <= r && !visited[j][k]) {
                        count++;
                        visited[j][k] = true;
                    }
                }
            }
        }
    }

    return count;
}