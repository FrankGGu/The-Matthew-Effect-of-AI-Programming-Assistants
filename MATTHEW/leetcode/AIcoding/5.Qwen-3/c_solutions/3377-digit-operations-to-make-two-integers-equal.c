#include <stdio.h>
#include <stdlib.h>

int minOperations(int x, int y) {
    int operations = 0;
    while (x != y) {
        if (x > y) {
            if (x % 2 == 0) {
                x /= 2;
            } else {
                x += 1;
            }
        } else {
            y /= 2;
        }
        operations++;
    }
    return operations;
}