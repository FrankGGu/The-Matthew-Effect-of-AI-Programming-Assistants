#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* memLeak(int memory1, int memory2) {
    int *res = (int*)malloc(3 * sizeof(int));
    int i = 1;

    while (memory1 >= i || memory2 >= i) {
        if (memory1 >= memory2) {
            memory1 -= i;
        } else {
            memory2 -= i;
        }
        i++;
    }

    res[0] = i;
    res[1] = memory1;
    res[2] = memory2;

    return res;
}