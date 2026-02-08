#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCostSetTime(int startAt, int moveCost, int pushCost, int targetSeconds) {
    int minCost = INT_MAX;

    for (int minutes = 0; minutes <= 99; minutes++) {
        int seconds = targetSeconds - minutes * 60;
        if (seconds < 0 || seconds > 99) continue;

        int num1 = minutes;
        int num2 = seconds;

        int digits[4] = {num1 / 10, num1 % 10, num2 / 10, num2 % 10};
        int firstNonZero = -1;
        for (int i = 0; i < 4; i++) {
            if (digits[i] != 0) {
                firstNonZero = i;
                break;
            }
        }

        if (firstNonZero == -1) firstNonZero = 3;

        int current = startAt;
        int cost = 0;
        for (int i = firstNonZero; i < 4; i++) {
            int digit = digits[i];
            if (digit != current) {
                cost += moveCost;
                current = digit;
            }
            cost += pushCost;
        }

        if (cost < minCost) {
            minCost = cost;
        }
    }

    return minCost;
}