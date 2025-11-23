#include <stdio.h>
#include <stdlib.h>

int countColoredCells(int p) {
    int total = 1;
    for (int i = 1; i <= p; i++) {
        total += 4 * (i - 1);
    }
    return total;
}