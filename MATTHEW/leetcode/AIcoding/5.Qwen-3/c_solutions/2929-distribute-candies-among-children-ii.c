#include <stdio.h>
#include <stdlib.h>

int distributeCandies(int n, int limit) {
    int* candies = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        candies[i] = 0;
    }

    int remaining = n;
    for (int i = 0; i < n && remaining > 0; i++) {
        int give = (remaining > limit) ? limit : remaining;
        candies[i] = give;
        remaining -= give;
    }

    return *candies;
}