#include <stdio.h>
#include <stdlib.h>

bool isReachable(int x, int y) {
    while (x > 0 && y > 0) {
        if (x % 2 == 0 && y % 2 == 0) {
            x /= 2;
            y /= 2;
        } else if (x % 2 == 0) {
            x /= 2;
        } else if (y % 2 == 0) {
            y /= 2;
        } else {
            break;
        }
    }
    return x == 1 && y == 1;
}