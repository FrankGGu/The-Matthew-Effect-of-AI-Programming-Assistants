#include <stdio.h>
#include <stdlib.h>

int maximumEnemyFortsThatCanBeCaptured(int* forts, int fortsSize) {
    int max = 0;
    int count = 0;
    for (int i = 0; i < fortsSize; i++) {
        if (forts[i] == 1) {
            if (count > 0) {
                max = (count > max) ? count : max;
                count = 0;
            }
        } else if (forts[i] == -1) {
            count = 0;
        } else {
            count++;
        }
    }
    return max;
}