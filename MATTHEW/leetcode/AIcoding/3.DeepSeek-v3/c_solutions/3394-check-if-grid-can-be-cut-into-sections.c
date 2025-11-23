#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return (*(int**)a)[0] - (*(int**)b)[0];
}

int cmp2(const void* a, const void* b) {
    return (*(int**)a)[1] - (*(int**)b)[1];
}

int check(int** rectangles, int rectanglesSize, int* rectanglesColSize, int isVertical) {
    int n = rectanglesSize;
    int** arr = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        arr[i] = (int*)malloc(2 * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        if (isVertical) {
            arr[i][0] = rectangles[i][0];
            arr[i][1] = rectangles[i][2];
        } else {
            arr[i][0] = rectangles[i][1];
            arr[i][1] = rectangles[i][3];
        }
    }

    if (isVertical) {
        qsort(arr, n, sizeof(int*), cmp);
    } else {
        qsort(arr, n, sizeof(int*), cmp2);
    }

    int count = 0;
    int maxEnd = arr[0][1];

    for (int i = 1; i < n; i++) {
        if (arr[i][0] >= maxEnd) {
            count++;
        }
        if (arr[i][1] > maxEnd) {
            maxEnd = arr[i][1];
        }
    }

    for (int i = 0; i < n; i++) {
        free(arr[i]);
    }
    free(arr);

    return count >= 2;
}

bool checkValidCuts(int n, int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    return check(rectangles, rectanglesSize, rectanglesColSize, 1) || 
           check(rectangles, rectanglesSize, rectanglesColSize, 0);
}