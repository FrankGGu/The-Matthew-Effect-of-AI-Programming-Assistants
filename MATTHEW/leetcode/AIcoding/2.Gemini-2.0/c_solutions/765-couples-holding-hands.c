#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minSwapsCouples(int* row, int rowSize) {
    int ans = 0;
    int pos[rowSize];
    for (int i = 0; i < rowSize; i++) {
        pos[row[i]] = i;
    }

    for (int i = 0; i < rowSize; i += 2) {
        int first = row[i];
        int second = (first % 2 == 0) ? first + 1 : first - 1;
        if (row[i + 1] != second) {
            int swap_pos = pos[second];
            int temp = row[i + 1];
            row[i + 1] = second;
            row[swap_pos] = temp;

            pos[second] = i + 1;
            pos[temp] = swap_pos;
            ans++;
        }
    }
    return ans;
}