bool isReachable(int x, int y, int targetX, int targetY) {
    while (targetX > x || targetY > y) {
        if (targetX > targetY) {
            targetX -= targetY;
        } else {
            targetY -= targetX;
        }
    }
    return (targetX == x && targetY == y) || (targetX == 0 && targetY == 0);
}