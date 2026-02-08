#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int rand7();

int rand10() {
    int row, col, idx;
    do {
        row = rand7();
        col = rand7();
        idx = (row - 1) * 7 + col;
    } while (idx > 40);
    return 1 + (idx - 1) % 10;
}