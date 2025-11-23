#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countLatticePoints(int** circles, int circlesSize, int* circlesColSize){
    int count = 0;
    bool points[201][201] = {false};

    for (int i = 0; i < circlesSize; i++) {
        int x = circles[i][0];
        int y = circles[i][1];
        int r = circles[i][2];

        for (int j = x - r; j <= x + r; j++) {
            for (int k = y - r; k <= y + r; k++) {
                if (j >= 0 && j <= 200 && k >= 0 && k <= 200) {
                    if ((j - x) * (j - x) + (k - y) * (k - y) <= r * r && !points[j][k]) {
                        count++;
                        points[j][k] = true;
                    }
                }
            }
        }
    }

    return count;
}