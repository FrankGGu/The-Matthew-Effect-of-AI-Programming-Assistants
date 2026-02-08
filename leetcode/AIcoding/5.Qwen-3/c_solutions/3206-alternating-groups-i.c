#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numberOfAlternatingGroups(int* colors, int n) {
    int count = 0;
    for (int i = 0; i < n; i++) {
        int prev = (i - 1 + n) % n;
        int next = (i + 1) % n;
        if (colors[i] != colors[prev] && colors[i] != colors[next]) {
            count++;
        }
    }
    return count;
}