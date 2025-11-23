#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int n) {
    int count = 0;
    while (n > 0) {
        if (n % 2 == 0) {
            n /= 2;
        } else {
            if ((n == 3) || ((n + 1) % 4 == 0)) {
                n++;
            } else {
                n--;
            }
        }
        count++;
    }
    return count;
}