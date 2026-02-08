#include <stdio.h>
#include <stdlib.h>

int aobGame(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        if (i % 2 == 1) {
            count++;
        }
    }
    return count;
}