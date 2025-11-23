#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] != y[0]) return x[0] - y[0];
    return x[1] - y[1];
}

int videoStitching(int** clips, int clipsSize, int* clipsColSize, int T){
    qsort(clips, clipsSize, sizeof(int*), compare);
    int res = 0;
    int curEnd = 0;
    int nextEnd = 0;
    int i = 0;
    while (i < clipsSize && curEnd < T) {
        if (clips[i][0] > curEnd) {
            return -1;
        }
        while (i < clipsSize && clips[i][0] <= curEnd) {
            nextEnd = nextEnd > clips[i][1] ? nextEnd : clips[i][1];
            i++;
        }
        res++;
        curEnd = nextEnd;
    }
    return curEnd >= T ? res : -1;
}