#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[0] - y[0];
}

bool haveConflict(int* event1, int event1Size, int* event2, int event2Size) {
    qsort(event1, 1, sizeof(int) * 2, compare);
    qsort(event2, 1, sizeof(int) * 2, compare);

    if (event1[1] < event2[0] || event2[1] < event1[0]) {
        return false;
    }
    return true;
}