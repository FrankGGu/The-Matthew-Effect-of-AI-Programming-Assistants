#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxBuilding(int n, int** restrictions, int restrictionsSize, int* restrictionsColSize) {
    int** arr = (int**)malloc(sizeof(int*) * (restrictionsSize + 2));
    for (int i = 0; i < restrictionsSize + 2; i++) {
        arr[i] = (int*)malloc(sizeof(int) * 2);
    }

    arr[0][0] = 1;
    arr[0][1] = 0;
    arr[restrictionsSize + 1][0] = n;
    arr[restrictionsSize + 1][1] = n - 1;

    for (int i = 0; i < restrictionsSize; i++) {
        arr[i + 1][0] = restrictions[i][0];
        arr[i + 1][1] = restrictions[i][1];
    }

    qsort(arr, restrictionsSize + 2, sizeof(int*), compare);

    for (int i = 1; i < restrictionsSize + 2; i++) {
        arr[i][1] = fmin(arr[i][1], arr[i - 1][1] + arr[i][0] - arr[i - 1][0]);
    }

    for (int i = restrictionsSize; i >= 0; i--) {
        arr[i][1] = fmin(arr[i][1], arr[i + 1][1] + arr[i + 1][0] - arr[i][0]);
    }

    int ans = 0;
    for (int i = 0; i < restrictionsSize + 1; i++) {
        int a = arr[i][0], b = arr[i][1];
        int x = arr[i + 1][0], y = arr[i + 1][1];
        int dist = abs(x - a);
        int h = abs(b - y);
        int curr = max(b, y) + (dist - h) / 2;
        ans = max(ans, curr);
    }

    for (int i = 0; i < restrictionsSize + 2; i++) {
        free(arr[i]);
    }
    free(arr);

    return ans;
}