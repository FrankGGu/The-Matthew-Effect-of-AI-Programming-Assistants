typedef struct {
    int x, y;
} Point;

int dirs[8][2] = {{0,1},{1,0},{0,-1},{-1,0},{1,1},{1,-1},{-1,1},{-1,-1}};

bool isValid(int x, int y) {
    return x >= 1 && x <= 8 && y >= 1 && y <= 8;
}

int countCombinations(char** pieces, int piecesSize, int** positions, int positionsSize, int* positionsColSize) {
    int n = piecesSize;
    Point start[n];
    for (int i = 0; i < n; i++) {
        start[i].x = positions[i][0];
        start[i].y = positions[i][1];
    }

    int res = 0;
    int maxStep = 8;

    for (int mask = 0; mask < (1 << (3 * n)); mask++) {
        int dir[n], step[n];
        int m = mask;
        bool valid = true;
        for (int i = 0; i < n; i++) {
            int d = m & 7;
            m >>= 3;
            if (pieces[i][0] == 'r' && d >= 4) {
                valid = false;
                break;
            }
            if (pieces[i][0] == 'b' && d < 4) {
                valid = false;
                break;
            }
            dir[i] = d;
            step[i] = maxStep;
        }
        if (!valid) continue;

        for (int s = 1; s <= maxStep; s++) {
            bool stop = true;
            for (int i = 0; i < n; i++) {
                if (step[i] > s) {
                    step[i] = s;
                    stop = false;
                }
            }
            if (stop) break;

            bool conflict = false;
            for (int i = 0; i < n && !conflict; i++) {
                int dx = dirs[dir[i]][0] * step[i];
                int dy = dirs[dir[i]][1] * step[i];
                int nx = start[i].x + dx;
                int ny = start[i].y + dy;
                if (!isValid(nx, ny)) {
                    conflict = true;
                    break;
                }
                for (int j = i + 1; j < n; j++) {
                    int dx2 = dirs[dir[j]][0] * step[j];
                    int dy2 = dirs[dir[j]][1] * step[j];
                    int nx2 = start[j].x + dx2;
                    int ny2 = start[j].y + dy2;
                    if (nx == nx2 && ny == ny2) {
                        conflict = true;
                        break;
                    }
                }
            }
            if (!conflict) {
                res++;
            } else {
                for (int i = 0; i < n; i++) {
                    if (step[i] == s) {
                        step[i] = maxStep;
                    }
                }
            }
        }
    }
    return res;
}