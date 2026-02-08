#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfBoomerangs(int** points, int pointsSize, int* pointsColSize){
    int ans = 0;
    for (int i = 0; i < pointsSize; i++) {
        int* count = (int*)malloc(sizeof(int) * pointsSize);
        for (int k = 0; k < pointsSize; k++) {
            count[k] = 0;
        }

        int* dists = (int*)malloc(sizeof(int) * pointsSize);
        for (int j = 0; j < pointsSize; j++) {
            if (i == j) continue;
            int dx = points[i][0] - points[j][0];
            int dy = points[i][1] - points[j][1];
            int dist = dx * dx + dy * dy;
            dists[j] = dist;
        }

        for (int j = 0; j < pointsSize; j++) {
            if (i == j) continue;
            int dist = dists[j];
            int cnt = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (i == k) continue;
                if (dists[k] == dist) {
                    cnt++;
                }
            }
            ans += cnt- (j == i ? 1:0);

        }

        free(dists);
        free(count);
    }
    return ans;
}