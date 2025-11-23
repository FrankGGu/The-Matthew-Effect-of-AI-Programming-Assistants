int numMovesStonesII(int* stones, int stonesSize) {
    qsort(stones, stonesSize, sizeof(int), cmp);
    int max_gap = stones[stonesSize - 1] - stones[0] - stonesSize + 1;
    int min_moves = 2;

    for (int i = 0; i < stonesSize; i++) {
        if (stones[i] == i + stones[0]) {
            min_moves = 0;
        }
    }

    for (int i = 0; i < stonesSize - 1; i++) {
        if (stones[i + 1] - stones[i] == 1) {
            min_moves = 1;
        }
    }

    if (max_gap == 0) {
        min_moves = 0;
    } else if (max_gap == 1 || max_gap == 2) {
        min_moves = 1;
    } else if (max_gap == 3) {
        min_moves = min_moves == 2 ? 2 : 1;
    }

    return (min_moves == 2) ? 2 : min_moves;
}

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}