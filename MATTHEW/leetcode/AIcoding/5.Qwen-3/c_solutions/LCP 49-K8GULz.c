#include <stdio.h>
#include <stdlib.h>

int findTheWinner(int n, int k) {
    int *people = (int *)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        people[i] = i + 1;
    }

    int current = 0;
    while (n > 1) {
        current = (current + k - 1) % n;
        for (int i = current; i < n - 1; i++) {
            people[i] = people[i + 1];
        }
        n--;
    }

    int result = people[0];
    free(people);
    return result;
}