#include <stdbool.h>

bool isReachable(int targetX, int targetY) {
    while (targetX > 0 && targetY > 0) {
        if (targetX == 1 && targetY == 1) return true;
        if (targetX % 2 == 0) {
            targetX /= 2;
            continue;
        }
        if (targetY % 2 == 0) {
            targetY /= 2;
            continue;
        }
        if (targetX > targetY) {
            targetX -= targetY;
        } else {
            targetY -= targetX;
        }
    }
    return (targetX == 1 && targetY == 1);
}