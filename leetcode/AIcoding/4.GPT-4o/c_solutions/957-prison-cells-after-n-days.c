int* prisonAfterNDays(int* cells, int cellsSize, int N, int* returnSize) {
    int* result = (int*)malloc(cellsSize * sizeof(int));
    int seen[1 << cellsSize];
    memset(seen, -1, sizeof(seen));

    int state = 0;
    for (int i = 0; i < cellsSize; i++) {
        state = (state << 1) | cells[i];
    }

    for (int day = 0; day < N; day++) {
        if (seen[state] != -1) {
            int cycle_length = day - seen[state];
            N = (N - day) % cycle_length + day;
            break;
        }
        seen[state] = day;

        int next_state = 0;
        for (int i = 1; i < cellsSize - 1; i++) {
            if (cells[i - 1] == cells[i + 1]) {
                next_state |= (1 << i);
            }
        }
        state = next_state;
    }

    for (int i = 0; i < cellsSize; i++) {
        result[i] = (state >> (cellsSize - 1 - i)) & 1;
    }
    *returnSize = cellsSize;
    return result;
}