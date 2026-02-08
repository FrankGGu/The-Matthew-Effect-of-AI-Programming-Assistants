int findLatestStep(int* arr, int arrSize, int m) {
    if (m == arrSize) return arrSize;

    int* length = (int*)calloc(arrSize + 2, sizeof(int));
    int* parent = (int*)malloc((arrSize + 2) * sizeof(int));
    for (int i = 0; i <= arrSize + 1; i++) {
        parent[i] = i;
    }

    int count = 0;
    int last = -1;

    for (int step = 0; step < arrSize; step++) {
        int pos = arr[step];
        int left = pos - 1;
        int right = pos + 1;

        length[pos] = 1;

        if (length[left] > 0) {
            if (length[left] == m) count--;
            length[pos] += length[left];
            parent[left] = pos;
        }

        if (length[right] > 0) {
            if (length[right] == m) count--;
            length[pos] += length[right];
            parent[right] = pos;
        }

        if (length[pos] == m) count++;

        if (count > 0) last = step + 1;
    }

    free(length);
    free(parent);
    return last;
}