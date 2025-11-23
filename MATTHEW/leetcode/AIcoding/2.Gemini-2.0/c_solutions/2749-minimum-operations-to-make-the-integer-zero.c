#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int n) {
    int count = 0;
    while (n > 0) {
        if (n % 2 == 1) {
            count++;
            n++;
        } else {
            n /= 2;
        }
    }
    return count;
}