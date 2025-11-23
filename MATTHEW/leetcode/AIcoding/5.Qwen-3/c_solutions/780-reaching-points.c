#include <stdio.h>
#include <stdlib.h>

int reachingPoints(int sx, int sy, int tx, int ty) {
    while (tx >= sx && ty >= sy) {
        if (tx == sx && ty == sy) return 1;
        if (tx == sx) {
            if ((ty - sy) % tx == 0) return 1;
            else return 0;
        }
        if (ty == sy) {
            if ((tx - sx) % ty == 0) return 1;
            else return 0;
        }
        if (tx > ty) {
            tx = tx % ty;
        } else {
            ty = ty % tx;
        }
    }
    return 0;
}