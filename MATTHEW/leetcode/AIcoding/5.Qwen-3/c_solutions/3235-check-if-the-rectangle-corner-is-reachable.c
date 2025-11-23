#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool canReachCorner(int n, int m, int x, int y) {
    if (x == 0 || y == 0 || x == n || y == m) return true;
    if (x > n || y > m) return false;
    if ((x % 2 == 0 && y % 2 == 0) || (x % 2 == 1 && y % 2 == 1)) return true;
    return false;
}