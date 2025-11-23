#include <stdio.h>
#include <stdlib.h>

int minCost(char* s) {
    int n = 0;
    while (s[n] != '\0') n++;

    int cost = 0;
    int i = 0;
    while (i < n) {
        int j = i;
        while (j < n && s[j] == s[i]) j++;
        int count = j - i;
        if (count > 1) {
            cost += (count - 1) * (count) / 2;
        }
        i = j;
    }
    return cost;
}