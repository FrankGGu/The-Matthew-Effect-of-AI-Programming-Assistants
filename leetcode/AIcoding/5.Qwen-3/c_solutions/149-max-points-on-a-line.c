#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int maxPoints(Point* points, int pointsSize) {
    if (pointsSize <= 1) return pointsSize;

    int max_points = 0;

    for (int i = 0; i < pointsSize; i++) {
        int same = 1;
        int duplicate = 0;
        int count = 0;
        int hash_size = 1000;
        char** hash = (char**)malloc(hash_size * sizeof(char*));
        for (int j = 0; j < hash_size; j++) {
            hash[j] = (char*)malloc(20 * sizeof(char));
        }

        for (int j = 0; j < pointsSize; j++) {
            if (i == j) continue;
            if (points[i].x == points[j].x && points[i].y == points[j].y) {
                duplicate++;
                continue;
            }

            int dx = points[j].x - points[i].x;
            int dy = points[j].y - points[i].y;

            int gcd_val = gcd(dx, dy);
            dx /= gcd_val;
            dy /= gcd_val;

            if (dx < 0) {
                dx = -dx;
                dy = -dy;
            } else if (dx == 0) {
                dy = 1;
            } else if (dy == 0) {
                dx = 1;
            }

            char key[20];
            sprintf(key, "%d,%d", dx, dy);

            int found = 0;
            for (int k = 0; k < hash_size; k++) {
                if (strcmp(hash[k], key) == 0) {
                    found = 1;
                    break;
                }
            }

            if (!found) {
                for (int k = 0; k < hash_size; k++) {
                    if (hash[k][0] == '\0') {
                        strcpy(hash[k], key);
                        break;
                    }
                }
                count++;
            }
        }

        max_points = (max_points > (count + same + duplicate)) ? max_points : (count + same + duplicate);

        for (int j = 0; j < hash_size; j++) {
            free(hash[j]);
        }
        free(hash);
    }

    return max_points;
}

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}