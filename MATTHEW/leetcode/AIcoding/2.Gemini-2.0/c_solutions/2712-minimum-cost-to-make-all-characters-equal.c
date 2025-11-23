#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(char * s) {
    int n = strlen(s);
    int cost = 0;
    for (int i = 0; i < n - 1; i++) {
        if (s[i] != s[i + 1]) {
            cost += (i + 1) < (n - i - 1) ? (i + 1) : (n - i - 1);
        }
    }
    return cost;
}