#include <stdio.h>
#include <stdlib.h>

int maxHeight(int n, int k) {
    int height = 0;
    while (n >= k) {
        n -= k;
        height++;
        k--;
    }
    return height;
}