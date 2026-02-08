#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

bool isLeap(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

int calculateDayOfYear(int year, int month, int day) {
    int daysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if (isLeap(year)) {
        daysInMonth[2] = 29;
    }

    int totalDays = 0;
    for (int i = 1; i < month; i++) {
        totalDays += daysInMonth[i];
    }
    totalDays += day;
    return totalDays;
}

char* intToBinaryString(int n) {
    if (n == 0) {
        char* result = (char*)malloc(2 * sizeof(char));
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    char* binaryString = (char*)malloc(33 * sizeof(char)); 
    if (binaryString == NULL) return NULL;

    int i = 0;
    while (n > 0) {
        binaryString[i++] = (n % 2 == 0) ? '0' : '1';
        n /= 2;
    }
    binaryString[i] = '\0';

    int length = i;
    for (int j = 0; j < length / 2; j++) {
        char temp = binaryString[j];
        binaryString[j] = binaryString[length - 1 - j];
        binaryString[length - 1 - j] = temp;
    }
    return binaryString;
}

char* convertDateToBinary(char* date) {
    int year, month, day;
    sscanf(date, "%d-%d-%d", &year, &month, &day);

    int dayNum = calculateDayOfYear(year, month, day);

    return intToBinaryString(dayNum);
}