#include <stdio.h>
#include <stdlib.h>

int minDominoRotations(int* row1, int row1Size, int* row2, int row2Size) {
    int count1[7] = {0}, count2[7] = {0};
    int same[7] = {0};

    for (int i = 0; i < row1Size; i++) {
        count1[row1[i]]++;
        count2[row2[i]]++;
        if (row1[i] == row2[i]) {
            same[row1[i]]++;
        }
    }

    int minRotations = row1Size;
    for (int i = 1; i <= 6; i++) {
        if (count1[i] + count2[i] - same[i] == row1Size) {
            minRotations = (row1Size - count1[i]) < minRotations ? (row1Size - count1[i]) : minRotations;
        }
    }

    return minRotations;
}