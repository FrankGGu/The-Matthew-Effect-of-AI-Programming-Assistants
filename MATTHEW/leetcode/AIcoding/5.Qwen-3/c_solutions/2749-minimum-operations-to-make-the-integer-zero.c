#include <stdio.h>
#include <stdlib.h>

int minimumOperations(int num) {
    int n = num;
    int operations = 0;
    while (n > 0) {
        if (n % 10 == 0) {
            n /= 10;
        } else {
            n -= 1;
        }
        operations++;
    }
    return operations;
}