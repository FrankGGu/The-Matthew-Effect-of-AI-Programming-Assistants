int getPower(int x) {
    int steps = 0;
    while (x != 1) {
        if (x % 2 == 0) {
            x /= 2;
        } else {
            x = 3 * x + 1;
        }
        steps++;
    }
    return steps;
}

int compare(const void* a, const void* b) {
    int* pa = (int*)a;
    int* pb = (int*)b;
    int powerA = getPower(pa[0]);
    int powerB = getPower(pb[0]);
    if (powerA != powerB) {
        return powerA - powerB;
    }
    return pa[0] - pb[0];
}

int getKth(int lo, int hi, int k) {
    int n = hi - lo + 1;
    int** arr = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        arr[i] = (int*)malloc(2 * sizeof(int));
        arr[i][0] = lo + i;
        arr[i][1] = getPower(lo + i);
    }

    qsort(arr, n, sizeof(int*), compare);

    int result = arr[k-1][0];

    for (int i = 0; i < n; i++) {
        free(arr[i]);
    }
    free(arr);

    return result;
}