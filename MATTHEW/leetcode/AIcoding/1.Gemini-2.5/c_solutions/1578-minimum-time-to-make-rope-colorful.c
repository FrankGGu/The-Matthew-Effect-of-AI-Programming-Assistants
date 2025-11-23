#include <string.h>
#include <stdlib.h>

int minCost(char * colors, int* neededTime, int neededTimeSize){
    int totalCost = 0;
    int n = strlen(colors);

    if (n == 0) {
        return 0;
    }

    for (int i = 0; i < n - 1; ++i) {
        if (colors[i] == colors[i+1]) {
            if (neededTime[i] < neededTime[i+1]) {
                totalCost += neededTime[i];
            } else {
                totalCost += neededTime[i+1];
                // Swap neededTime[i] and neededTime[i+1] to ensure neededTime[i] always holds the smaller value
                // for the next comparison if current neededTime[i+1] is removed.
                // This effectively means we are keeping the larger time at the current 'i+1' position
                // for future comparisons if the sequence of same colors continues.
                int temp = neededTime[i];
                neededTime[i] = neededTime[i+1];
                neededTime[i+1] = temp;
            }
        }
    }

    return totalCost;
}