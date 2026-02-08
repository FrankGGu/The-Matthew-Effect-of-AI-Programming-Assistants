#include <stdbool.h>

bool validSquare(int* p1, int* p2, int* p3, int* p4) {
    int points[4][2] = {{p1[0], p1[1]}, {p2[0], p2[1]}, {p3[0], p3[1]}, {p4[0], p4[1]}};
    int dist[6] = {0};
    int k = 0;

    for (int i = 0; i < 4; i++) {
        for (int j = i + 1; j < 4; j++) {
            int dx = points[i][0] - points[j][0];
            int dy = points[i][1] - points[j][1];
            dist[k++] = dx * dx + dy * dy;
        }
    }

    for (int i = 0; i < 6; i++) {
        for (int j = i + 1; j < 6; j++) {
            if (dist[i] == dist[j]) {
                dist[j] = -1; // Mark as used
                break;
            }
        }
    }

    int side = 0, diag = 0;
    for (int i = 0; i < 6; i++) {
        if (dist[i] > 0) {
            if (side == 0) {
                side = dist[i];
            } else if (diag == 0) {
                diag = dist[i];
            } else if (dist[i] == side) {
                side = -1; // More than 4 sides
            } else if (dist[i] == diag) {
                diag = -1; // More than 2 diagonals
            } else {
                return false;
            }
        }
    }

    return side > 0 && diag > 0 && side * 2 == diag;
}