#include <stdio.h>
#include <stdlib.h>

bool isReachableAtTime(int sx, int sy, int dx, int dy, int time) {
    int dx_abs = abs(dx - sx);
    int dy_abs = abs(dy - sy);
    if (dx_abs == 0 && dy_abs == 0) {
        return time >= 0;
    }
    if (dx_abs + dy_abs <= time) {
        return true;
    }
    return false;
}