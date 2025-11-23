#include <stdlib.h>
#include <string.h>

typedef struct {
    int dx;
    int dy;
} Slope;

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

Slope getSlope(int x1, int y1, int x2, int y2) {
    int dx = x2 - x1;
    int dy = y2 - y1;

    if (dx == 0) {
        return (Slope){0, 1};
    }
    if (dy == 0) {
        return (Slope){1, 0};
    }

    int g = gcd(dx, dy);
    dx /= g;
    dy /= g;

    if (dx < 0) {
        dx = -dx;
        dy = -dy;
    }

    return (Slope){dx, dy};
}

int maxPoints(int** points, int pointsSize, int* pointsColSize) {
    if (pointsSize < 2) return pointsSize;

    int maxCount = 1;

    for (int i = 0; i < pointsSize; i++) {
        Slope* slopes = malloc(sizeof(Slope) * (pointsSize - i - 1));
        int slopeCount = 0;

        for (int j = i + 1; j < pointsSize; j++) {
            slopes[slopeCount++] = getSlope(points[i][0], points[i][1], points[j][0], points[j][1]);
        }

        for (int k = 0; k < slopeCount; k++) {
            int count = 2;
            for (int m = k + 1; m < slopeCount; m++) {
                if (slopes[k].dx == slopes[m].dx && slopes[k].dy == slopes[m].dy) {
                    count++;
                }
            }
            if (count > maxCount) {
                maxCount = count;
            }
        }

        free(slopes);
    }

    return maxCount;
}