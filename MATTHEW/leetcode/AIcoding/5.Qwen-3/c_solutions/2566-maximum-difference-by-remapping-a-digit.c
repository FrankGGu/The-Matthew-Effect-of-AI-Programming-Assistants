#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int possibleMax(int num, int digit) {
    char str[12];
    sprintf(str, "%d", num);
    for (int i = 0; i < strlen(str); i++) {
        if (str[i] == digit + '0') {
            str[i] = '9';
            return atoi(str);
        }
    }
    return num;
}

int possibleMin(int num, int digit) {
    char str[12];
    sprintf(str, "%d", num);
    for (int i = 0; i < strlen(str); i++) {
        if (str[i] == digit + '0') {
            str[i] = '0';
            return atoi(str);
        }
    }
    return num;
}

int maxDiff(int num) {
    int maxVal = num;
    int minVal = num;
    for (int d = 0; d <= 9; d++) {
        int tempMax = possibleMax(num, d);
        if (tempMax > maxVal) {
            maxVal = tempMax;
        }
        int tempMin = possibleMin(num, d);
        if (tempMin < minVal) {
            minVal = tempMin;
        }
    }
    return maxVal - minVal;
}