#include <stdio.h>
#include <stdlib.h>

int totalMoney(int n) {
    int total = 0;
    int week = 0;
    int day = 0;
    int current = 1;

    while (n > 0) {
        total += current;
        current++;
        day++;
        if (day == 7) {
            day = 0;
            week++;
            current = 1 + week;
        }
        n--;
    }

    return total;
}