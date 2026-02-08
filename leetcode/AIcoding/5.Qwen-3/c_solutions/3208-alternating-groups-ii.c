#include <stdio.h>
#include <stdlib.h>

int numberOfAlternatingGroups(int* ranges, int rangesSize) {
    int n = rangesSize;
    int count = 0;
    for (int i = 0; i < n; i++) {
        int a = ranges[i];
        int b = ranges[(i + 1) % n];
        int c = ranges[(i + 2) % n];
        if ((a != b && b != c) || (a != b && a != c)) {
            count++;
        }
    }
    return count;
}