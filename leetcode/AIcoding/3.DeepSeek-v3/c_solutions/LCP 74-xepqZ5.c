int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int fieldOfGreatestBlessing(int** forceField, int forceFieldSize, int* forceFieldColSize) {
    int n = forceFieldSize;
    long long* x_vals = (long long*)malloc(2 * n * sizeof(long long));
    long long* y_vals = (long long*)malloc(2 * n * sizeof(long long));
    int x_count = 0, y_count = 0;

    for (int i = 0; i < n; i++) {
        long long x = forceField[i][0];
        long long y = forceField[i][1];
        long long side = forceField[i][2];
        x_vals[x_count++] = 2 * x - side;
        x_vals[x_count++] = 2 * x + side;
        y_vals[y_count++] = 2 * y - side;
        y_vals[y_count++] = 2 * y + side;
    }

    int cmp(const void* a, const void* b) {
        long long diff = *(long long*)a - *(long long*)b;
        return diff < 0 ? -1 : (diff > 0 ? 1 : 0);
    }

    qsort(x_vals, x_count, sizeof(long long), cmp);
    qsort(y_vals, y_count, sizeof(long long), cmp);

    int res = 0;
    for (int i = 0; i < x_count; i++) {
        for (int j = 0; j < y_count; j++) {
            long long x = x_vals[i];
            long long y = y_vals[j];
            int cnt = 0;
            for (int k = 0; k < n; k++) {
                long long cx = forceField[k][0] * 2;
                long long cy = forceField[k][1] * 2;
                long long side = forceField[k][2] * 2;
                if (x >= cx - side && x <= cx + side && y >= cy - side && y <= cy + side) {
                    cnt++;
                }
            }
            res = max(res, cnt);
        }
    }

    free(x_vals);
    free(y_vals);
    return res;
}