#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int color;
    int count;
} Ball;

int compare(const void *a, const void *b) {
    return ((Ball *)b)->count - ((Ball *)a)->count;
}

long long getDesiredSum(int** stock, int stockSize, int* stockColSize, int k) {
    Ball* balls = (Ball*)malloc(stockSize * sizeof(Ball));
    for (int i = 0; i < stockSize; i++) {
        balls[i].color = i;
        balls[i].count = stock[i][0];
    }
    qsort(balls, stockSize, sizeof(Ball), compare);

    long long total = 0;
    int i = 0;
    while (k > 0 && i < stockSize) {
        int take = (k >= balls[i].count) ? balls[i].count : k;
        total += (long long)take * (balls[i].count + (balls[i].count - take + 1)) / 2;
        k -= take;
        i++;
    }
    free(balls);
    return total;
}