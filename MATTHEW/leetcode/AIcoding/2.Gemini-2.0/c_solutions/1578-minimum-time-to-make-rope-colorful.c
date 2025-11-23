#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(char * colors, int* neededTime, int neededTimeSize){
    int n = strlen(colors);
    int ans = 0;
    int i = 0;
    while (i < n - 1) {
        if (colors[i] == colors[i + 1]) {
            int j = i;
            int maxTime = neededTime[i];
            int sumTime = neededTime[i];
            while (j < n - 1 && colors[j] == colors[j + 1]) {
                j++;
                sumTime += neededTime[j];
                if (neededTime[j] > maxTime) {
                    maxTime = neededTime[j];
                }
            }
            ans += (sumTime - maxTime);
            i = j + 1;
        } else {
            i++;
        }
    }
    return ans;
}