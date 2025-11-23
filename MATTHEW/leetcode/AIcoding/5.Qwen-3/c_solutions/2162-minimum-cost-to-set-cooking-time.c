#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minCostToSetTime(int targetSeconds, int costKeys, int costDisplay) {
    int minCost = INT_MAX;
    int maxPossible = 9999;

    for (int time = 1; time <= maxPossible; time++) {
        int seconds = time;
        int minutes = 0;

        while (seconds >= 60) {
            minutes++;
            seconds -= 60;
        }

        if (minutes * 60 + seconds == targetSeconds) {
            int keyPresses = 0;
            int displayDigits = 0;

            if (minutes > 0) {
                keyPresses += 1;
                displayDigits += 1;
            }

            if (seconds > 0) {
                keyPresses += 1;
                displayDigits += 1;
            }

            if (minutes > 0 && seconds > 0) {
                keyPresses += 1;
                displayDigits += 1;
            }

            if (minutes > 0) {
                keyPresses += 1;
                displayDigits += 1;
            }

            if (seconds < 10) {
                keyPresses += 1;
                displayDigits += 1;
            } else {
                keyPresses += 2;
                displayDigits += 2;
            }

            int cost = keyPresses * costKeys + displayDigits * costDisplay;
            if (cost < minCost) {
                minCost = cost;
            }
        }
    }

    return minCost;
}