#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPoints(char * rings) {
    int rods[10] = {0};
    int n = strlen(rings);

    for (int i = 0; i < n; i += 2) {
        char color = rings[i];
        int rodIndex = rings[i + 1] - '0';

        if (color == 'R') {
            rods[rodIndex] |= 1;
        } else if (color == 'G') {
            rods[rodIndex] |= 2;
        } else {
            rods[rodIndex] |= 4;
        }
    }

    int count = 0;
    for (int i = 0; i < 10; i++) {
        if (rods[i] == 7) {
            count++;
        }
    }

    return count;
}