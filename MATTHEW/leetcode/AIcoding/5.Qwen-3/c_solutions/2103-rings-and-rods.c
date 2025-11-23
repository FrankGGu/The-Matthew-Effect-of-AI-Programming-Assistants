#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countPoints(char* ring) {
    int count[3] = {0};
    for (int i = 0; i < strlen(ring); i += 2) {
        char color = ring[i];
        int index = ring[i + 1] - '0';
        if (color == 'R') count[0]++;
        else if (color == 'G') count[1]++;
        else if (color == 'B') count[2]++;
    }
    int result = 0;
    for (int i = 0; i < 3; i++) {
        if (count[i] >= 3) result++;
    }
    return result;
}