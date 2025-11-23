#include <stdio.h>
#include <stdlib.h>

int findCenter(int** edges, int edgesSize, int* edgesColSize) {
    int a = edges[0][0];
    int b = edges[0][1];
    if (edges[1][0] == a || edges[1][1] == a) {
        return a;
    } else {
        return b;
    }
}