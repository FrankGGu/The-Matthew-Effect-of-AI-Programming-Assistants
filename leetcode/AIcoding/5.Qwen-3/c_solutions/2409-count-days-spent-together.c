#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int daysInMonth[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

int convertToDayOfYear(char* date) {
    int year = 0, month = 0, day = 0;
    sscanf(date, "%d-%d-%d", &year, &month, &day);
    int dayOfYear = 0;
    for (int i = 0; i < month - 1; i++) {
        dayOfYear += daysInMonth[i];
    }
    dayOfYear += day;
    return dayOfYear;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int countDaysTogether(char* arriveAlice, char* leaveAlice, char* arriveBob, char* leaveBob) {
    int a_start = convertToDayOfYear(arriveAlice);
    int a_end = convertToDayOfYear(leaveAlice);
    int b_start = convertToDayOfYear(arriveBob);
    int b_end = convertToDayOfYear(leaveBob);

    int overlap_start = max(a_start, b_start);
    int overlap_end = min(a_end, b_end);

    if (overlap_start > overlap_end) {
        return 0;
    }

    return overlap_end - overlap_start + 1;
}