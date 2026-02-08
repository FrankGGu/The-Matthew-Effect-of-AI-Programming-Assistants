#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int flipStringToMonotoneIncreasing(char* s) {
    int n = 0;
    while (s[n] != '\0') n++;

    int count = 0;
    int flips = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '0') {
            flips = min(flips + 1, count);
        } else {
            count++;
        }
    }

    return flips;
}