#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int shortestSubarray(int* A, int ASize, int K) {
    long* prefix = (long*)malloc((ASize + 1) * sizeof(long));
    for (int i = 0; i < ASize; i++) {
        prefix[i + 1] = prefix[i] + A[i];
    }

    int* deque = (int*)malloc((ASize + 1) * sizeof(int));
    int front = 0, back = 0;
    int minLength = INT_MAX;

    for (int i = 0; i <= ASize; i++) {
        while (front < back && prefix[i] - prefix[deque[front]] >= K) {
            minLength = (minLength < i - deque[front]) ? minLength : (i - deque[front]);
            front++;
        }
        while (front < back && prefix[i] <= prefix[deque[back - 1]]) {
            back--;
        }
        deque[back++] = i;
    }

    free(prefix);
    free(deque);

    return minLength == INT_MAX ? -1 : minLength;
}