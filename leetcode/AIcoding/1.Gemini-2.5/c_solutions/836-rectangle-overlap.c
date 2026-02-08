#include <stdbool.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

bool isRectangleOverlap(int* rec1, int rec1Size, int* rec2, int rec2Size) {
    bool x_overlap = max(rec1[0], rec2[0]) < min(rec1[2], rec2[2]);
    bool y_overlap = max(rec1[1], rec2[1]) < min(rec1[3], rec2[3]);

    return x_overlap && y_overlap;
}