#include <string.h>
#include <stdlib.h>
#include <stdio.h>

int convertTime(char* current, char* correct) {
    int currentHour, currentMinute;
    int correctHour, correctMinute;

    sscanf(current, "%d:%d", &currentHour, &currentMinute);
    sscanf(correct, "%d:%d", &correctHour, &correctMinute);

    int currentTotalMinutes = currentHour * 60 + currentMinute;
    int correctTotalMinutes = correctHour * 60 + correctMinute;

    int diff = correctTotalMinutes - currentTotalMinutes;
    int operations = 0;

    operations += diff / 60;
    diff %= 60;

    operations += diff / 15;
    diff %= 15;

    operations += diff / 5;
    diff %= 5;

    operations += diff;

    return operations;
}