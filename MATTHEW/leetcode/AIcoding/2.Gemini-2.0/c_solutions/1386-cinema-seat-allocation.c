#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxNumberOfFamilies(int n, int** reservedSeats, int reservedSeatsSize, int* reservedSeatsColSize) {
    int reserved[n + 1];
    for (int i = 0; i <= n; i++) {
        reserved[i] = 0;
    }

    for (int i = 0; i < reservedSeatsSize; i++) {
        int row = reservedSeats[i][0];
        int col = reservedSeats[i][1];
        if (col >= 2 && col <= 9) {
            reserved[row] |= (1 << (col - 2));
        }
    }

    int count = 0;
    for (int i = 1; i <= n; i++) {
        bool alloc1 = (reserved[i] & 0x0F) == 0;
        bool alloc2 = (reserved[i] & 0x3C) == 0;
        bool alloc3 = (reserved[i] & 0xF0) == 0;

        if (alloc1 && alloc3) {
            count += 2;
        } else if (alloc1 || alloc2 || alloc3) {
            count += 1;
        }
    }

    return count;
}