#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maxValueOfEquation(int** points, int pointsSize, int* pointsColSize, int k) {
    int res = -2e9;
    int deque[pointsSize];
    int head = 0, tail = 0;

    for (int i = 0; i < pointsSize; i++) {
        while (head <= tail && points[i][0] - points[deque[head]][0] > k) {
            head++;
        }

        if (head <= tail) {
            res = max(res, points[i][1] + points[deque[head]][1] + points[i][0] - points[deque[head]][0]);
        }

        while (head <= tail && points[i][1] - points[i][0] >= points[deque[tail]][1] - points[deque[tail]][0]) {
            tail--;
        }

        deque[++tail] = i;
    }

    return res;
}