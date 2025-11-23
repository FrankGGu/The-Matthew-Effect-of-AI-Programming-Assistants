#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findTheWinner(int n, int k) {
    int* people = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        people[i] = i + 1;
    }

    int current = 0;
    while (n > 1) {
        current = (current + k - 1) % n;
        memmove(people + current, people + current + 1, (n - current - 1) * sizeof(int));
        n--;
    }

    int result = people[0];
    free(people);
    return result;
}