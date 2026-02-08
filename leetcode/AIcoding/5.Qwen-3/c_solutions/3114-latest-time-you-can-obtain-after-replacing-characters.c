#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findLatestTime(char* time) {
    char* result = (char*)malloc(6 * sizeof(char));
    strcpy(result, time);

    if (result[0] == '?') {
        if (result[1] == '?') {
            result[0] = '2';
            result[1] = '3';
        } else if (result[1] <= '3') {
            result[0] = '2';
        } else {
            result[0] = '1';
        }
    }

    if (result[1] == '?') {
        if (result[0] == '2') {
            result[1] = '3';
        } else {
            result[1] = '9';
        }
    }

    if (result[3] == '?') {
        result[3] = '5';
    }

    if (result[4] == '?') {
        result[4] = '9';
    }

    return result;
}