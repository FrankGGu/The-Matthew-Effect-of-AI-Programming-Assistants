#include <stdio.h>
#include <stdlib.h>

int findTheWinner(int n, int k) {
    int *circle = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        circle[i] = i + 1;
    }

    int current = 0;
    while (n > 1) {
        current = (current + k - 1) % n;
        for (int i = current; i < n - 1; i++) {
            circle[i] = circle[i + 1];
        }
        n--;
    }

    int result = circle[0];
    free(circle);
    return result;
}