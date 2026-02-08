#include <stdio.h>
#include <stdlib.h>

int minOperations(int x, int y, int a) {
    if (x == y) return 0;
    int count = 0;
    while (x > 0) {
        if (x % a == 0) {
            x /= a;
            count++;
        } else {
            int rem = x % a;
            x -= rem;
            count += rem;
        }
        if (x == y) return count;
    }
    return -1;
}