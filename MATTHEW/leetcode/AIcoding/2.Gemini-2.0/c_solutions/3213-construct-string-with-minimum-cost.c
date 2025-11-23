#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(char * s, int cost[]) {
    int n = strlen(s);
    if (n <= 1) return 0;

    int totalCost = 0;
    int i = 0;
    while (i < n - 1) {
        if (s[i] == s[i + 1]) {
            int j = i;
            int maxCost = cost[i];
            int currentCost = cost[i];

            while (j < n - 1 && s[j] == s[j + 1]) {
                j++;
                currentCost += cost[j];
                if (cost[j] > maxCost) {
                    maxCost = cost[j];
                }
            }

            totalCost += (currentCost - maxCost);
            i = j + 1;
        } else {
            i++;
        }
    }

    return totalCost;
}