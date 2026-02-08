#include <stdio.h>
#include <stdlib.h>

int convertTime(char* current, char* correct) {
    int currMin = (current[0] - '0') * 600 + (current[1] - '0') * 60 + (current[3] - '0') * 10 + (current[4] - '0');
    int corrMin = (correct[0] - '0') * 600 + (correct[1] - '0') * 60 + (correct[3] - '0') * 10 + (correct[4] - '0');

    int diff = corrMin - currMin;
    int count = 0;

    int denominations[] = {60, 15, 5, 1};
    int size = sizeof(denominations) / sizeof(denominations[0]);

    for (int i = 0; i < size; i++) {
        if (diff >= denominations[i]) {
            count += diff / denominations[i];
            diff %= denominations[i];
        }
    }

    return count;
}