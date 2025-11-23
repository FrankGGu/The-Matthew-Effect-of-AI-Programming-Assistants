int reinitializePermutation(int n) {
    int* perm = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        perm[i] = i;
    }

    int count = 0;
    int found = 0;

    while (!found) {
        count++;
        int* arr = (int*)malloc(n * sizeof(int));
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                arr[i] = perm[i / 2];
            } else {
                arr[i] = perm[n / 2 + (i - 1) / 2];
            }
        }

        found = 1;
        for (int i = 0; i < n; i++) {
            if (arr[i] != i) {
                found = 0;
                break;
            }
        }

        for (int i = 0; i < n; i++) {
            perm[i] = arr[i];
        }
        free(arr);
    }

    free(perm);
    return count;
}