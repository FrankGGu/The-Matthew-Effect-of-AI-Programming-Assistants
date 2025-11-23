#include <stdio.h>
#include <stdlib.h>

int minOperations(int n) {
    int operations = 0;
    for (int i = 1; i < n; i += 2) {
        operations += (n - i) / 2;
    }
    return operations;
}