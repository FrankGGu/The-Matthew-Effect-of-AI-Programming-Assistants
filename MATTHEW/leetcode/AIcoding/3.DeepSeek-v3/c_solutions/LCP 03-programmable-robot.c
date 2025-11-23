bool robot(char* command, int** obstacles, int obstaclesSize, int* obstaclesColSize, int x, int y) {
    int cx = 0, cy = 0;
    int len = strlen(command);

    for (int i = 0; i < len; i++) {
        if (command[i] == 'U') cy++;
        else cx++;
    }

    if (!canReach(command, x, y, cx, cy, len)) {
        return false;
    }

    for (int i = 0; i < obstaclesSize; i++) {
        int ox = obstacles[i][0];
        int oy = obstacles[i][1];
        if (ox <= x && oy <= y && canReach(command, ox, oy, cx, cy, len)) {
            return false;
        }
    }

    return true;
}

bool canReach(char* command, int x, int y, int cx, int cy, int len) {
    int rounds = fmin(x / cx, y / cy);
    int nx = rounds * cx;
    int ny = rounds * cy;

    if (nx == x && ny == y) return true;

    for (int i = 0; i < len; i++) {
        if (command[i] == 'U') ny++;
        else nx++;

        if (nx > x || ny > y) return false;
        if (nx == x && ny == y) return true;
    }

    return false;
}