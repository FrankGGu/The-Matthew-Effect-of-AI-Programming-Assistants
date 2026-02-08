int[] fillMissing(int[] data) {
    int n = sizeof(data) / sizeof(data[0]);
    int i, j;

    for (i = 0; i < n; i++) {
        if (data[i] == -1) {
            for (j = i - 1; j >= 0 && data[j] == -1; j--);
            if (j >= 0) {
                data[i] = data[j];
            }
        }
    }

    for (i = n - 1; i >= 0; i--) {
        if (data[i] == -1) {
            for (j = i + 1; j < n && data[j] == -1; j++);
            if (j < n) {
                data[i] = data[j];
            }
        }
    }

    return data;
}