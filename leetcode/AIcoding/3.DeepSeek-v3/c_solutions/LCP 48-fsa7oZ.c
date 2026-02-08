typedef struct {
    int x;
    int y;
} Point;

int dirs[8][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}};

int minKnightMoves(int x, int y) {
    x = abs(x);
    y = abs(y);

    if (x + y == 0) return 0;
    if (x + y == 1) return 3;
    if (x == 1 && y == 1) return 2;

    int res = fmax(fmax((x + 1) / 2, (y + 1) / 2), (x + y + 2) / 3);
    res += (res ^ (x + y)) & 1;

    return res;
}