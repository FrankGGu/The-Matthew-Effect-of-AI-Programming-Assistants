#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** validSquare(char** points, int pointsSize, int* returnSize) {
    int n = pointsSize;
    char** result = (char**)malloc(4 * sizeof(char*));
    for (int i = 0; i < 4; i++) {
        result[i] = (char*)malloc(5 * sizeof(char));
    }
    int index = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (i != j) {
                int dx = atoi(strstr(points[i], ",") + 1) - atoi(points[j]);
                int dy = atoi(points[i]) - atoi(points[j] + strlen(points[j]) + 1);
                int dist2 = dx * dx + dy * dy;
                int count = 0;
                for (int k = 0; k < n; k++) {
                    if (k != i && k != j) {
                        int dx2 = atoi(strstr(points[i], ",") + 1) - atoi(points[k]);
                        int dy2 = atoi(points[i]) - atoi(points[k] + strlen(points[k]) + 1);
                        int dist2k = dx2 * dx2 + dy2 * dy2;
                        if (dist2 == dist2k) {
                            count++;
                        }
                    }
                }
                if (count == 2) {
                    int dx3 = atoi(strstr(points[j], ",") + 1) - atoi(points[k]);
                    int dy3 = atoi(points[j]) - atoi(points[k] + strlen(points[k]) + 1);
                    int dist2j = dx3 * dx3 + dy3 * dy3;
                    if (dist2 == dist2j) {
                        int dx4 = atoi(strstr(points[i], ",") + 1) - atoi(points[k]);
                        int dy4 = atoi(points[i]) - atoi(points[k] + strlen(points[k]) + 1);
                        int dist2i = dx4 * dx4 + dy4 * dy4;
                        if (dist2 == dist2i) {
                            strcpy(result[index++], points[i]);
                            strcpy(result[index++], points[j]);
                            strcpy(result[index++], points[k]);
                            strcpy(result[index++], points[3 - i - j - k]);
                            *returnSize = 4;
                            return result;
                        }
                    }
                }
            }
        }
    }

    *returnSize = 0;
    return result;
}