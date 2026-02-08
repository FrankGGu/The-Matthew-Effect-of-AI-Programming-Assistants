#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheIntegerAddedToArray(int* changed, int changedSize) {
    if (changedSize % 2 != 0) {
        return -1;
    }

    int count[100001] = {0};
    for (int i = 0; i < changedSize; i++) {
        count[changed[i]]++;
    }

    for (int i = 0; i <= 50000; i++) {
        if (count[i] > 0) {
            if (count[i] > count[i * 2]) {
                return -1;
            }
            count[i * 2] -= count[i];
            count[i] = 0;
            if (i == 0 && count[0] > 0) {
                count[0] = 0;
            }
        }
    }

    for (int i = 0; i < changedSize; i++) {
        if (changed[i] <= 50000 && changed[i] != 0) {
            return changed[i];
        }
    }

    return 0;
}