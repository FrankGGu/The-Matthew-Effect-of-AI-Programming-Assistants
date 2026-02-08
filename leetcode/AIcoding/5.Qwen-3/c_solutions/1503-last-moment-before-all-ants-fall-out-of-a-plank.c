#include <stdio.h>
#include <stdlib.h>

int getLastMoment(int n, int* left, int leftSize, int* right, int rightSize) {
    int maxLeft = 0;
    for (int i = 0; i < leftSize; i++) {
        if (left[i] > maxLeft) {
            maxLeft = left[i];
        }
    }

    int minRight = n;
    for (int i = 0; i < rightSize; i++) {
        if (right[i] < minRight) {
            minRight = right[i];
        }
    }

    return (maxLeft > (n - minRight)) ? maxLeft : (n - minRight);
}