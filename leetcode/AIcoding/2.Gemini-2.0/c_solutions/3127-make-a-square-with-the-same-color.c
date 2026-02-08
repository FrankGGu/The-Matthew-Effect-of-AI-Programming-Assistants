#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool solve(int n, int m, int k, int r1, int c1, int r2, int c2) {
    if (k == 0) return false;
    if (r1 == r2 && c1 == c2) return true;

    int dist = abs(r1 - r2) + abs(c1 - c2);
    if (dist % 2 == 0) return true;
    else return false;
}