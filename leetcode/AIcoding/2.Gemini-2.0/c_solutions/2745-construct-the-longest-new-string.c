#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestNewString(int x, int y, int z) {
    int ans = 0;
    if (x == y) {
        ans = (x + y + z) * 2;
    } else {
        ans = (2 * (x < y ? x : y)) + z * 2 + 2;
    }
    return ans;
}