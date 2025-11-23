typedef struct {
    int rows;
    int cols;
    int* grid;
    int pos;
    int dir; // 0: right, 1: down, 2: left, 3: up
} BlackBox;

BlackBox* blackBoxCreate(int n, int m) {
    BlackBox* obj = (BlackBox*)malloc(sizeof(BlackBox));
    obj->rows = n;
    obj->cols = m;
    obj->grid = (int*)calloc(n * m, sizeof(int));
    obj->pos = 0;
    obj->dir = 0;
    return obj;
}

int blackBoxOpen(BlackBox* obj, int index) {
    obj->grid[index] = 1;
    return -1;
}

int blackBoxClose(BlackBox* obj, int index) {
    obj->grid[index] = 0;
    return -1;
}

int blackBoxReflect(BlackBox* obj) {
    int n = obj->rows;
    int m = obj->cols;
    int* grid = obj->grid;
    int pos = obj->pos;
    int dir = obj->dir;

    while (1) {
        if (dir == 0) { // right
            int next_pos = pos + 1;
            if (next_pos % m == 0) {
                return pos;
            }
            if (grid[next_pos]) {
                dir = 3;
            } else {
                pos = next_pos;
            }
        } else if (dir == 1) { // down
            int next_pos = pos + m;
            if (next_pos >= n * m) {
                return pos;
            }
            if (grid[next_pos]) {
                dir = 2;
            } else {
                pos = next_pos;
            }
        } else if (dir == 2) { // left
            int next_pos = pos - 1;
            if (pos % m == 0) {
                return pos;
            }
            if (grid[next_pos]) {
                dir = 1;
            } else {
                pos = next_pos;
            }
        } else if (dir == 3) { // up
            int next_pos = pos - m;
            if (next_pos < 0) {
                return pos;
            }
            if (grid[next_pos]) {
                dir = 0;
            } else {
                pos = next_pos;
            }
        }
    }
}

void blackBoxFree(BlackBox* obj) {
    free(obj->grid);
    free(obj);
}