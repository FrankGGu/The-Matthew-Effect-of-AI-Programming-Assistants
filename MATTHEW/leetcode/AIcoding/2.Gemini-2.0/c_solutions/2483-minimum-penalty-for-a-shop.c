#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minPenalty(char * customers) {
    int n = 0;
    while (customers[n] != '\0') {
        n++;
    }

    int penalty = 0;
    for (int i = 0; i < n; i++) {
        if (customers[i] == 'Y') {
            penalty++;
        }
    }

    int min_penalty = penalty;
    int min_hour = 0;

    for (int i = 0; i < n; i++) {
        if (customers[i] == 'Y') {
            penalty--;
        } else {
            penalty++;
        }

        if (penalty < min_penalty) {
            min_penalty = penalty;
            min_hour = i + 1;
        }
    }

    return min_hour;
}