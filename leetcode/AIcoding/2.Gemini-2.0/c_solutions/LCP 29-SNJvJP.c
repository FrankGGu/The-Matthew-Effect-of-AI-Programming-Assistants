#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int orchestraLayout(int num, int row, int col) {
    long long layer = (long long)fmin(fmin(row, col), fmin(num - 1 - row, num - 1 - col));
    long long perimeter = (long long)num - 2 * layer;
    long long count = 4 * perimeter - 4;
    long long start = layer;
    long long result = layer * (2 * num - 2 * layer - 1);
    if (row == layer) {
        result += col - layer + 1;
    } else if (col == num - 1 - layer) {
        result += perimeter + row - layer;
    } else if (row == num - 1 - layer) {
        result += 2 * perimeter - 1 + num - 1 - layer - col;
    } else {
        result += 3 * perimeter - 2 + num - 1 - layer - row;
    }
    return (int)((result - 1) % 9 + 1);
}