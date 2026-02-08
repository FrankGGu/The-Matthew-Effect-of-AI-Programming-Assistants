#include <stdio.h>
#include <stdlib.h>

int mirrorReflection(int height, int width) {
    int m = 1, n = 1;
    while (m * height != n * width) {
        if (m * height < n * width) {
            m++;
        } else {
            n++;
        }
    }
    if (m % 2 == 0 && n % 2 == 1) {
        return 0;
    } else if (m % 2 == 1 && n % 2 == 1) {
        return 1;
    } else {
        return 2;
    }
}